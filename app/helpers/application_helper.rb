
module ApplicationHelper 
  
  def will_paginate(collection, options = {})
    options.merge!({
      #:previous_label => t( 'previous'),
      #:next_label => (t 'next')
      :previous_label => t( 'previous'),
      :next_label => (t 'next')
    })
    
    super(collection, options)
  end


   
  def sortable(column, title = nil)  
    title ||= column.titleize  
    css_class = (column == sort_column) ? "#{sort_direction}" : nil  
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}   
  end

  def can_edit?
    user_signed_in? && current_user.admin_or_super?
  end
  
  def is_super?
    user_signed_in? && current_user.super?
  end
  
  
  
  
  def format_user_text(input)
      output = "<p>#{input.strip}</p>"

      # do some formatting
      output.gsub!(/\r\n/, "\n")       # remove CRLFs
      output.gsub!(/^$\s*/m, "\n")     # remove blank lins
      output.gsub!(/\n{3,}/, "\n\n")   # replace \n\n\n... with \n\n
      output.gsub!(/\n\n/, '</p><p>')  # embed stuff in paragraphs
      output.gsub!(/\n/, '<br/>')      # nl2br

      sanitize_fu(output, 'p') 
    end
  
  
  
  
  
  # Adapted from http://ideoplex.com/id/1138/sanitize-html-in-ruby
  def sanitize_fu(html, okTags = 'a href, b, br, p, i, em')
    # no closing tag necessary for these
    soloTags = ["br","hr"]
  
    # Build hash of allowed tags with allowed attributes
    tags = okTags.downcase().split(',').collect!{ |s| s.split(' ') }
    allowed = Hash.new
    tags.each do |s|
      key = s.shift
      allowed[key] = s
    end
  
    # Analyze all <> elements
    stack = Array.new
    result = html.gsub( /(<.*?>)/m ) do | element |
      if element =~ /\A<\/(\w+)/ then
        # </tag>
        tag = $1.downcase
        if allowed.include?(tag) && stack.include?(tag) then
          # If allowed and on the stack
          # Then pop down the stack
          top = stack.pop
          out = "</#{top}>"
          until top == tag do
            top = stack.pop
            out << "</#{top}>"
          end
          out
        end
      elsif element =~ /\A<(\w+)\s*\/>/
        # <tag />
        tag = $1.downcase
        if allowed.include?(tag) then
          "<#{tag} />"
        end
      elsif element =~ /\A<(\w+)/ then
        # <tag ...>
        tag = $1.downcase
        if allowed.include?(tag) then
          if ! soloTags.include?(tag) then
            stack.push(tag)
          end
          if allowed[tag].length == 0 then
            # no allowed attributes
            "<#{tag}>"
          else
            # allowed attributes?
            out = "<#{tag}"
            while ( $' =~ /(\w+)=("[^"]+")/ )
              attr = $1.downcase
              valu = $2
              if allowed[tag].include?(attr) then
                out << " #{attr}=#{valu}"
              end
            end
            out << ">"
          end
        end
      end
    end
  
    # eat up unmatched leading >
    while result.sub!(/\A([^<]*)>/m) { $1 } do end
  
    # eat up unmatched trailing <
    while result.sub!(/<([^>]*)\Z/m) { $1 } do end
  
    # clean up the stack
    if stack.length > 0 then
      result << "</#{stack.reverse.join('></')}>"
    end
  
    result
  end
  
end