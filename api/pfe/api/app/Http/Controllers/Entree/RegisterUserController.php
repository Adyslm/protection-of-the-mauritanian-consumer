<?php

namespace App\Http\Controllers\Entree;
use App\Http\Requests\Entree\Etape3RegisterRequest;
use App\Http\Requests\Entree\Etape1RegisterRequest;
use App\Http\Requests\Entree\Etape2RegisterRequest;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Hash;
use App\Models\User;
use App\Services\ChinguisoftSmsService;


class RegisterUserController extends Controller
{
    
    protected $smsService;

    public function __construct(ChinguisoftSmsService $smsService)
    {
        $this->smsService = $smsService;
    }

    public function register1(Etape1RegisterRequest $request){
          $tel=$request->tel;
          
        try {
            $smsResponse = $this->smsService->sendValidationSms($tel, 'ar');
            // Vérification de la réponse de l'API SMS
            if (!empty($smsResponse['code'])) {
            $user = new User();
            $user->tel = $tel;
            $user->code = $smsResponse['code'];
            $user->code_expire_at = now()->addMinutes(10);
            $user->save();
            return response()->json(['message' => 'Code envoyé avec succès.'], 201);
            }
        } catch (\Exception $e) {
            
            return response()->json(['message' => 'Erreur lors de l\'envoi du SMS : ' . $e->getMessage()], 500);
        }

    }


    public function register2(Etape2RegisterRequest $request){
       // Chercher l'utilisateur par téléphone
       $user = User::where('tel', $request->tel)->first();
         // Vérifie si le code correcte et s'il est valide
    if ($user->code !== $request->code || now()->gt($user->code_expire_at)) { //gt=>(superieur ou egal)
        return response()->json(['message' => 'Code invalide ou expiré'], 422);
    }else{
        $user->reset_code();
    }
    return response()->json(['message' => 'Code vérifié avec succès.']);
    }
    
    public function registerComplete(Etape3RegisterRequest $request)
    {
        $user = User::where('tel', $request->tel)->first();

        $user->timestamps = false; 
        $user->name = $request->name;
        $user->nni = $request->nni;
        $user->password = Hash::make($request->password);
        $user->save();

        $success['token']=$user->createToken('user',['app::all'])->plainTextToken;
        $success['name']=$user->name;
        $success['success']=true;
        $success['message']='Inscription complte.';
            
        return response()->json($success,200); 

    }
}
