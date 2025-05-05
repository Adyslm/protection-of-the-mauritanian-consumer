<?php
// app/Http/Controllers/ChefAuthController.php
namespace App\Http\Controllers;

use App\Models\Chef;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class ChefController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|min:3|max:255',
            'NNI' => 'required|numeric|digits:10|unique:chefs',
            'phone_num' => 'required|string|size:8|unique:chefs',
            'moughataa' => 'required|string',
            'mdp' => 'required|string|size:4',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $chef = Chef::create([
            'name' => $request->name,
            'NNI' => $request->NNI,
            'phone_num' => $request->phone_num,
            'moughataa' => $request->moughataa,
            'mdp' => Hash::make($request->mdp),
        ]);

        $token = $chef->createToken('ChefToken')->plainTextToken;

        return response()->json([
            'chef' => $chef,
            'token' => $token
        ], 201);
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone_num' => 'required|string|size:8',
            'mdp' => 'required|string|size:4',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $chef = Chef::where('phone_num', $request->phone_num)->first();

        if (!$chef || !Hash::check($request->mdp, $chef->mdp)) {
            return response()->json(['message' => 'Identifiants invalides'], 401);
        }

        $token = $chef->createToken('ChefToken')->plainTextToken;

        return response()->json([
            'chef' => $chef,
            'token' => $token
        ], 200);
    }

    



    // Recuperer chef info
 /**
 * Récupère les informations du chef authentifié via son token
 * 
 * @param Request $request
 * @return \Illuminate\Http\JsonResponse
 */
public function getAuthenticatedChef(Request $request)
{
    try {
        // Vérifie que l'utilisateur est authentifié
        if (!Auth::check()) {
            return response()->json([
                'success' => false,
                'message' => 'Non authentifié'
            ], 401);
        }

        // Récupère le chef authentifié
        $chef = Auth::user();
        
        // Formatage de la réponse (exclut les données sensibles)
        return response()->json([
            'success' => true,
            'data' => [
                'name' => $chef->name,
                'moughataa' => $chef->moughataa,
            ]
        ], 200);

    } catch (\Exception $e) {
        // Gestion des erreurs inattendues
        return response()->json([
            'success' => false,
            'message' => 'Erreur lors de la récupération des données',
            'error' => config('app.debug') ? $e->getMessage() : null
        ], 500);
    }
}

}