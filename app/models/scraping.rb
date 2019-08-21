class Scraping
  def self.movie_total
    links = []
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
    movie_urls("https://filmarks.com/list/genre/8")
    # current_page = agent.get('https://filmarks.com/list/genre')
    # elements = current_page.search('.c-list-line__item--has-bar a')
    # elements.each do |ele|
    #  links << ele.get_attribute('href')
    # end

    # links.each do |link|
    #   movie_urls('https://filmarks.com' + link)
    # end
  end


  def self.movie_urls(link)
    links = []
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
    # agent.user_agent_alias = 'Windows Chrome'
    next_url = ""

    while true
      # p next_url
      current_page = agent.get(link + next_url)
      elements = current_page.search('.p-movie-cassette__people__readmore .p-movie-cassette__readmore')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end
      # p links

      next_link = current_page.at('a.c-pagination__next')
      break unless next_link
      next_url = next_link.get_attribute('href')
      idx = next_url.index("?")
      next_url = next_url[idx..-1]
    end

    links.each do |link|
      get_product('https://filmarks.com' + link)
    end
  end
    
   def self.get_product
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
    page = agent.get(https://www.navitime.co.jp/category/0106001/13/)
    title = page.search('.spot_name').inner_text 
    image_url = page.at('.address_name').inner_text
    
    
    # product = Product.where(title: title).first_or_initialize
    # product.title = title
    # product.image_url = image_url
    # product.open_date = open_date
    # product.director = director
    # product.save
    # puts detail
     puts title
     puts image_url
    # puts open_data
    # puts director
   end
end