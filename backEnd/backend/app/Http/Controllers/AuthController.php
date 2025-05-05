<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function verify(Request $req)
    {
        // Validation rules for name and phone_num
        $rules = [
            'name' => 'required|string|min:3|max:255',
            'phone_num' => 'required|integer|min:8|regex:/^[0-9]+$/',
        ];

        $validator = Validator::make($req->all(), $rules);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        return response()->json(['status' => 'verified', 'name' => $req->name, 'phone_num' => $req->phone_num], 200);
    }

    public function validateUser(Request $req)
    {
        // Validation rules for NNI and mdp
        $rules = [
            'NNI' => 'required|integer|unique:users|regex:/^[0-9]{10}$/',
            'mdp' => 'required|string|min:4|max:4',
        ];

        $validator = Validator::make($req->all(), $rules);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Create new user in users table
        $user = User::create([
            'name' => $req->name,
            'NNI' => $req->NNI,
            'phone_num' => $req->phone_num,
            'mdp' => Hash::make($req->mdp),
        ]);

        $token = $user->createToken('Personal Access Token')->plainTextToken;
        $response = ['user' => $user, 'token' => $token];
        return response()->json($response, 200);
    }

    public function login(Request $req)
    {
        // Valider les entrées (en utilisant Validator::make)
        $rules = [
            'phone_num' => 'required|integer|min:8|regex:/^[0-9]+$/',
            'mdp' => 'required|string|min:4|max:4',
        ];
        $validator = Validator::make($req->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Trouver l'utilisateur par phone_num
        $user = User::where('phone_num', $req->phone_num)->first();

        // Si l'utilisateur existe et que le mot de passe est correct
        if ($user) {
            if (!Hash::check($req->mdp, $user->mdp)) {
                $response = ['message' => 'Mot de passe incorrect.'];
                return response()->json($response, 400);
            }
            $token = $user->createToken('Personal Access Token')->plainTextToken;
            $response = ['user' => $user, 'token' => $token];
            return response()->json($response, 200);
        } else {
            $response = ['message' => 'Numéro de téléphone incorrect.'];
            return response()->json($response, 400);
        }

        //Ce code ne sera jamais atteint, mais il est conservé pour plus de sécurité.
        $response = ['message' => 'Erreur de connexion inconnue.'];
        return response()->json($response, 400);
    }
}