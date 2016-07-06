namespace :scrape do
  desc "Scrape all cellphone data from amazon"
  task amazon_cellphones: :environment do
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'

    # Get the homepage
    page = agent.get('https://www.amazon.com/s/field-keywords=Cellphones')
    page_count = page.search('.pagnDisabled').text.to_i
    phone_count = 0

    page_count.times do |page_number|
      break if page_number == 3
      containers = page.search('.s-item-container')      
      containers.each do |container|
          title = container.search('.s-access-detail-page')
          next if title.empty?
          price = container.search('.s-price').text
          star_count = container.search('.a-icon-star').text
          image = container.search('.s-access-image').attribute('src').value
          Cellphone.create(title: title.text, price: price, star_count: star_count,
                             img_src: image)
          phone_count += 1
      end
      page.link_with(id: '#pagnNextLink').click
    end


    puts "#{phone_count} Cellphones created from Amazon"
  end

end