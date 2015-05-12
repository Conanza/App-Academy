require 'addressable/uri'
require 'rest-client'

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users',
#   query_values: {
#     'some_category[a_key]' => 'another value',
#     'some_category[a_second_key]' => 'yet another value',
#     'some_category[inner_inner_hash][key]' => 'value',
#     'something_else' => 'aaahhhhh'  }
# ).to_s
#
# puts RestClient.get(url)

#
# url2 = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users?name=what'
# ).to_s
#
# puts RestClient.post(url2, person: { name: "person" })


# new_user = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users.json',
# ).to_s
#
# puts RestClient.post(new_user, { user: { name: "batman" } })#, email: "notbrucewayne@gotham.com" }})


# a_user = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/2',
# ).to_s
#
# puts RestClient.get(a_user)

# an_update = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/4',
# ).to_s
#
# puts RestClient.patch(an_update, { user: { email: "notclarkkent@metropolis.com" }})

# a_destroy = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/3',
# ).to_s

#
# puts RestClient.delete(a_destroy)

new_user = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/',
).to_s

puts RestClient.post(new_user, { user: { username: 'Spiderman' }})
