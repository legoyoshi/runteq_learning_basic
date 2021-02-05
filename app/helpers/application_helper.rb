module ApplicationHelper
   def page_title(page_title = '', admin = false)
     base_title = if admin
                    'Ruby on Rails 学習記録(管理画面)'
                  else
                    'Ruby on Rails 学習記録'
                  end

     page_title.empty? ? base_title : page_title + ' | ' + base_title
   end
 end
