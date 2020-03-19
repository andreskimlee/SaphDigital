require 'award'
require 'update_blue_first'
require 'update_blue_compare'
require 'update_blue_star'
require 'update_normal_item'

## Each award has their own method / update_blue_first etc. 
# some notes, expires_in can go past 0. While quality cannot go past zero. Quantity also cannot exceed 50.

def update_quality(awards)
   awards.each do |award| 
    case award.name
  
    when "Blue First"
      update_blue_first(award)  
      
    ## Blue Distinction Plus do not change. too op
    when "Blue Distinction Plus"  
      
    when "Blue Compare"
      update_blue_compare(award)
      
    when "Blue Star"
      update_blue_star(award)

    when "NORMAL ITEM" 
      update_normal_item(award)
    end
  end 
end

## Additional notes, the NORMAL ITEM and Blue Star need a test case to ensure quality does not go below zero. This could happen for normal item when
    ## quality is at 1 and expires_in is at zero. In this case quality would be -1. Similar cases are present for Blue Star since it is not decrementing by 1. 
    ## Blue care also needs testing for when incrementing to ensure quality does not go past 50 


