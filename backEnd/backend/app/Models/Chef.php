<?php

// app/Models/Chef.php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;

class Chef extends Authenticatable
{
    use HasApiTokens, HasFactory;

    protected $fillable = [
        'name',
        'NNI',
        'phone_num',
        'moughataa',
        'mdp'
    ];

    protected $hidden = [
        'mdp',
        'remember_token',
    ];
}