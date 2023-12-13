# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create(
    email: "john@email.com",
    password: "123456",
    password_confirmation: "123456",
    name: "John",
    role: User.roles[:admin]
)

User.create(
    email: "bob@email.com",
    password: "123456",
    password_confirmation: "123456",
    name: "Bob",
    role: User.roles[:user]
)


10.times do |x|
    post = Post.create(
        title: "hello lads, this is my #{x}st post",
        body: "as expected this is clearly my #{x}st post but I need to write a little bit more unless this post ain't gonna be saved",
        user_id: User.first.id)
    
    5.times do |y|
        Comment.create(
            body: "yo nice post lad",
            user_id: User.second.id,
            post_id: post.id)
            
    end
end