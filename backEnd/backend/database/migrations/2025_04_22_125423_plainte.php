<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    // database/migrations/2024_03_25_create_plaintes_table.php
    public function up()
        {
            Schema::create('plaintes', function (Blueprint $table) {
                $table->id();
                $table->foreignId('id_citoyen')->constrained('users');
                $table->foreignId('id_controleur')->nullable()->constrained('users');
                $table->text('details');
                $table->string('image_path')->nullable();
                $table->string('adresse');
                $table->string('moughataa');
                $table->timestamps();
            });
        }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
};
