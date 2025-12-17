require "./catalog-browse"

use Metrics::Middleware
use Rack::Deflater

run Sinatra::Application
