<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Entree\RegisterUserController;
use App\Http\Controllers\Entree\LoginUserController;
use App\Http\Controllers\Entree\ForgetPasswordController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
//register user
Route::prefix('register/')->name('register.')->group(function (){
    Route::post('1',[RegisterUserController::class,'register1']);
    Route::post('2',[RegisterUserController::class,'register2']);
    Route::post('3',[RegisterUserController::class,'registerComplete']);
 });

//login
Route::post('login',[LoginUserController::class,'login']);

//forgetPassword
Route::prefix('forgetPassword/')->name('forgetpassword.')->group(function (){
    Route::post('envoyeCode',[ForgetPasswordController::class,'forgetPassword']);
    Route::post('verifiCode',[ForgetPasswordController::class,'verifiecode']);
    Route::post('nouveauPassword',[ForgetPasswordController::class,'nouveauPassword']);
 });

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
