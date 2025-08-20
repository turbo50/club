<?php

	require 'aws.phar';

	use Aws\SecretsManager\SecretsManagerClient;
	use Aws\Exception\AwsException;

	function parse_properties($filename) {
        $props = [];
        $lines = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

        foreach ($lines as $line) {
            $line = trim($line);

            // Ignorer les commentaires
            if (empty($line) || $line[0] === '#' || $line[0] === ';') {
                continue;
            }

            // Découper clé=valeur
            $parts = explode("=", $line, 2);
            if (count($parts) === 2) {
                $key = trim($parts[0]);
                $value = trim($parts[1]);
                $props[$key] = $value;
            }
        }

        return $props;
    }

    $config = parse_properties("param.properties");
	/*// Récupération depuis les variables d'environnement
	$secretName = getenv('AWS_SECRET_NAME') ?: 'default/secret/vault';
	$region = getenv('AWS_REGION') ?: 'eu-west-1';
	*/
    $secretName = $config['AWS_SECRET_NAME'];
    $region = $config['AWS_REGION'];
	// Création du client Secrets Manager
	$client = new SecretsManagerClient([
	    'version' => '2017-10-17',
	    'region'  => $region,
	]);

	try {
	    $result = $client->getSecretValue([
	        'SecretId' => $secretName,
	    ]);

	    // Récupération du secret
	    if (isset($result['SecretString'])) {
	        $secret = json_decode($result['SecretString'], true);
	    } else {
	        $secret = json_decode(base64_decode($result['SecretBinary']), true);
	    }

	    // Extraction des valeurs
	    $dbname   = $secret['NAME_BDD'];
	    $user     = $secret['USER_BDD'];
	    $password = $secret['PWD_BDD'];
	    $hostname = $secret['HOST_BDD'];

	} catch (AwsException $e) {
	    echo "Erreur lors de la récupération du secret : " . $e->getMessage();
	    die();
	}

	// Connexion MySQL
	global $con;
	$con = new mysqli($hostname, $user, $password, $dbname);
	if (mysqli_connect_errno()) {
	    echo "Échec de la connexion MySQL : " . mysqli_connect_error();
	    die();
	}
