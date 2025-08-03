require 'pagy/extras/bootstrap'
# require 'pagy/extras/nav'
# in config/initializers/pagy.rb

Pagy::DEFAULT[:limit] = 4
Pagy::DEFAULT[:size] = 2
# config/initializers/pagy.rb
# require 'pagy/extras/bootstrap'  # or whatever extras you're using
require 'pagy/extras/overflow'
require 'pagy/extras/metadata'
# etc.