<?php
/** The name of the database for WordPress */
// define( 'DB_NAME', '${MARIADB_NAME}' );
define( 'DB_NAME', 'wordpress' );

/** Database username */
// define( 'DB_USER', '${MARIADB_USER}' );
define( 'DB_USER', 'olahmami' );

/** Database password */
// define( 'DB_PASSWORD', '${MARIADB_PASS}' );
define( 'DB_PASSWORD', 'maria2024' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**For developers: WordPress debugging mode. */
define( 'WP_DEBUG', false );

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
