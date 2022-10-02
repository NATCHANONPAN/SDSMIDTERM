<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', "${db_name}" );

/** MySQL database username */
define( 'DB_USER', "${db_user}" );

/** MySQL database password */
define( 'DB_PASSWORD', "${db_pass}" );

/** MySQL hostname */
define( 'DB_HOST', "${db_host}:${db_port}" );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'ff#l8.H16>SD0O6TT+N-3n6c})7qc$u#A,{8M|X-G1% q`B+AEAcq:S?6@*Hp,+o');
define('SECURE_AUTH_KEY',  'H#(-7gUI>g`~R-3R)FPP1~C(d+]]m=ffMLiQu|b[cs_zga]VM0W4GFs2)+Sn~XIH');
define('LOGGED_IN_KEY',    'U2B9UKK@$(|2+9P ^F,2^>gG,|B=%DzD~Mpo=828A+LUH+c+0}tA!VHe|3]Nr%Hf');
define('NONCE_KEY',        '^O?jZPG<:$yZotjLphj|AiO_2Y)l{liWJIuD }}k$r+~TUC!%oHm`G|R<!%au@(L');
define('AUTH_SALT',        'kxEW$?418ialD|ENgi6N?f9N$y{aD?>{3;ERp&#v:@xYt#QKiL2CK5-0J3OuG,M,');
define('SECURE_AUTH_SALT', 'Z3AtQVg2vWeLc]w)+|:P;C:{>v;{n:M3>1gFx1y`~e)0[hfIIRbu}8U!b?,RY!Cj');
define('LOGGED_IN_SALT',   'Qmp+7O[DhRC8bY+%D|,*def|+y;SzgOxm^ t q0.3@1b-Bj.f>`~n7,;X_{.AK]{');
define('NONCE_SALT',       ']nv[l@OFqa|Q!-iz>N(3W-FVA^/F8eKcNUuKk4v!fXxauwgy---B madn#^ 9[eG');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );