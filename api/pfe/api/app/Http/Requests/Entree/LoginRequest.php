<?php

namespace App\Http\Requests\Entree;

use Illuminate\Foundation\Http\FormRequest;

class LoginRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'tel' => 'required',
            'password' => 'required',
        ];
    }
    public function messages()
    {
   return[
    
    'tel.required' => 'Le tel est obligatoire.',
    'tel.required' => 'Le motpass est obligatoire.',
            
    
   ];
    }
}
