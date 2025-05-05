<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Plainte; // <-- Import ajouté
use Illuminate\Support\Facades\Auth; // <-- Import ajouté

class PlainteController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'details' => 'required|string|max:2000',
            'adresse' => 'required|string|max:255',
            'moughataa' => 'required|string|max:255',
            'image' => 'nullable|image|max:2048',
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('plaintes', 'public');
        }

        $plainte = Plainte::create([
            'id_citoyen' => Auth::id(),
            'details' => $validated['details'],
            'adresse' => $validated['adresse'],
            'moughataa' => $validated['moughataa'],
            'image_path' => $imagePath,
        ]);

        return response()->json([
            'message' => 'Plainte enregistrée avec succès',
            'data' => $plainte
        ], 201);
    }

    public function index()
    {
        return Plainte::with(['citoyen', 'controleur'])->get();
    }
}