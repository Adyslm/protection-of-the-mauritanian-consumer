<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plainte extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_citoyen', 
        'id_controleur', 
        'details', 
        'image_path', 
        'adresse',
        'moughataa'
    ];

    public function citoyen()
    {
        return $this->belongsTo(User::class, 'id_citoyen');
    }

    public function controleur()
    {
        return $this->belongsTo(User::class, 'id_controleur');
    }
}