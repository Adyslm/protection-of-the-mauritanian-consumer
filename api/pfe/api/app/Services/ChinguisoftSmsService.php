<?php
namespace App\Services;

use GuzzleHttp\Client;

class ChinguisoftSmsService
{
    protected $client;
    protected $validationKey;
    protected $token;

    public function __construct()
    {
        $this->client = new Client();
        $this->validationKey = config('services.chinguisoft.key');
        $this->token = config('services.chinguisoft.token');
    }

    public function sendValidationSms($phone, $lang )
    {
        $url = "https://chinguisoft.com/api/sms/validation/{$this->validationKey}";

        $response = $this->client->post($url, [
            'headers' => [
                'Validation-token' => $this->token,
                'Content-Type' => 'application/json',
            ],
            'json' => [
                'phone' => $phone,
                'lang' => $lang,
                
            ],
        ]);

        return json_decode($response->getBody(), true);
    }
}
