<h1>
  <?=(strpos($_SERVER['SERVER_SOFTWARE'], 'Apache') !== false)
      ? 'Apache'
      : 'Nginx';
  ?>
</h1>
<?php phpinfo(); ?>
