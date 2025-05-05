<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController; 
use App\Http\Controllers\PlainteController;
use App\Http\Controllers\ChefController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// correct
Route::post('/auth/verify', [AuthController::class, 'verify']);
Route::post('/auth/validateUser', [AuthController::class, 'validateUser']);

Route::post('/auth/login', [AuthController::class, 'login']);
// correct
// Route::post('/auth/login', [AuthController::class, 'login'])->name('login');

// Route::get('/plaintes', [PlainteController::class, 'index']);

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

// Route::post('/plaintes', [PlainteController::class, 'store']); 
// Route::resource('chefs', ChefController::class);

// Route::post('/auth/login', [AuthController::class, 'login']);


// Route::middleware('auth:sanctum')->group(function () {
//     // Route::post('/plaintes', [PlainteController::class, 'store']);
//     Route::post('/plaintes', [PlainteController::class, 'store']); // Correct route
//     Route::get('/plaintes', [PlainteController::class, 'index']);
//     Route::get('/user', function (Request $request) {
//         return $request->user();
//     });
// });

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/plaintes', [PlainteController::class, 'store']);
    Route::get('/plaintes', [PlainteController::class, 'index']);
});



Route::prefix('chefs')->group(function () {
    Route::post('/register', [ChefController::class, 'register']); 
    Route::post('/login', [ChefController::class, 'login']);  
    Route::get('/chefs/{id}/name-moughataa', [ChefController::class, 'getChefById']);  
    // Route::get('/chefs/{id}', [ChefController::class, 'getChefById']);
});

Route::middleware('auth:sanctum')->get('/chefs/me', [ChefController::class, 'getAuthenticatedChef']);