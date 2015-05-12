require 'addressable/uri'
require 'rest-client'

def index_resource(resource)
  puts r = RestClient.get(create_url(resource))
  JSON.parse(r.body).last['id']
end

def create_user
  puts RestClient.post(create_url('users'),
    user: { username: ('a'..'f').to_a.shuffle.join }
  )
end

def create_contact
  puts RestClient.post(create_url('contacts'),
    contact: { name:  ('a'..'d').to_a.shuffle.join,
               email: ('a'..'d').to_a.shuffle.join,
               user_id: 2 }
  )
end

def show_resource(resource, id)
  puts RestClient.get(create_url(resource, id))
end

def update_user(id)
  puts RestClient.patch(create_url('users', id),
    user: { username: ('h'..'l').to_a.shuffle.join }
  )
end

def update_contact(id)
  puts RestClient.patch(create_url('contacts', id),
    contact: { name:  ('a'..'d').to_a.shuffle.join,
               email: ('a'..'d').to_a.shuffle.join,
               user_id: 2 }
  )
end

def delete_resource(resource, id)
  puts RestClient.delete(create_url(resource, id))
end

def create_url(resource, id = nil)
  ext = id.nil? ? '.html' : "/#{id}.html"
  Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/#{resource}#{ext}"
  ).to_s
end

user_id = index_resource('users')
create_user
show_resource('users', user_id)
update_user(user_id)
delete_resource('users', user_id)

contact_id = index_resource('contacts')
create_contact
show_resource('contacts', contact_id)
update_contact(contact_id)
delete_resource('contacts', contact_id)
