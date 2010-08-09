require "rubygems"
require "madmimi"

mimi = MadMimi.new('MAD_MIMI_USER', 'MAD_MIMI_PASS')

options = {
  :promotion_name => "blank_template",
  :recipients     => "Your Name <RECIPIENT_ADDRESS_HERE>",
  :from           => "CI Joe <SENDER_ADDRESS_HERE>",
  :subject        => "Public Service Announcement"
}

plaintext = "
  #{ENV['AUTHOR']} is a Real American Hero..
  
  Commit Message:
  #{ENV['MESSAGE']}

  Traced Output:
  #{ENV['OUTPUT']}
  
  CI Joe: YOUR_CI_URL_HERE
  because knowing is half the battle
"

mimi.send_plaintext(options, plaintext)