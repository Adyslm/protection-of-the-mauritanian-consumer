<?php

namespace App\Http\Controllers\Entree;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\Entree\LoginRequest;
use Auth;
use Hash;

class LoginUserController extends Controller
{
     public function login(LoginRequest $request){
        $donnee=[
            'tel'=>$request->tel,
            'password'=>$request->password,
        ];
        if(auth()->attempt($donnee)){
            $user=Auth::user();
            $user->tokens()->delete();
            $success['name']=$user->name;
            $success['token']=$user->createToken(request()->userAgent())->plainTextToken;
            $success['success']=true;
            $success['message']="login success";
            return response()->json($success,200);
        }else{
            return response()->json(['error'=>'tel ou mot de pass incorrect'],401);
        }
    }
}
