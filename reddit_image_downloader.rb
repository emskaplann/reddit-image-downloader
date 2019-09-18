#take photos from a subreddit of reddit 🤪
require 'rest-client'
require 'json'
require 'pry'
require 'open-uri'
require 'rubygems'
require 'mechanize'

def welcome
    puts "- - - Hi There! - - -"
    puts "Welcome to the - Reddit Image Downloader -"
    puts "-What does this programme do?"
    puts "- - This programme downloads all of the images from one subreddit you choose to one folder(directory) you want."
    puts "Please enter a subreddit link(you can copy+paste):"
    gets.chomp
end
def get_directory_from_the_user
    puts "Now please enter the directory you want:"
    puts "-Please note that, you need enter a -valid directory- otherwise programme will not work properly."
    puts "-And if you don't want to create a new folder (directory), your directory should look like this: /Users/your_username/the_folder(directory)_you_choose/ "
    puts "--But if you want to create a new folder for your images, simply you can write: /Users/your_username/the_folder_you_choose/new_folder_name/ "
    puts "---For Instance:"
    puts "--- /Users/emskaplann/images/car_photos/ "
    puts "--Please be carefull with slashes '/' "
    gets.chomp
end
#get from the welcome method

def get_photos(arg)
    response_str = RestClient.get("#{arg}.json")
    response_hash = JSON.parse(response_str)
    return response_hash
end

def get_links(hash2)
    x=0
    newarr_of_links = []
        newarr_of_links = hash2["data"]["children"].map{|link|
            link["data"]["thumbnail"] }
    return newarr_of_links
end

def download_photos_to_a_certain_folder(linksarray, dir)
    # the folder to download photos '/Users/emskaplann/test_apps'
    #this is a example for image name that we are downloading =>> VxN85T34V3h-Ei6WKKn4ybEpqmagEm-DEBZSxPwXEeE.jpg

    agent=Mechanize.new
    linksarray.each{|link|
        agent.get(link).save"#{dir}#{File.basename(link)}"
}
end

user_input1=welcome
directory_input=get_directory_from_the_user
hash = get_photos(user_input1)
link_of_photos = get_links(hash)
download_photos_to_a_certain_folder(link_of_photos, directory_input)


#response_hash["data"]["children"][0]["data"]["thumbnail"]
#this the path that gives us the link of thumbnail