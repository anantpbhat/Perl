
use Mojolicious::Lite;

get '/' => (text => 'I Love Mojolicious!');

app->start;
