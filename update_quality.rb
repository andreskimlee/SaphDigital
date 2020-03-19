require 'award'
# some notes, expires_in can go past 0. While quality cannot go past zero. Quantity also cannot exceed 50.
def update_quality(awards)
   awards.each do |award| 
    
    case award.name
    ## Blue first traits. Quality += 1 when expires_in > 0 and Quality += 2 when expires_in <= 0 
    when "Blue First"
      ## When quality is betweeen 0 and 50 we need to make changes to both quality + expires_in. 
      if award.quality < 50 && award.quality >= 0 
        ## Also check if our expires in is greater than zero. IF greater than zero we increment by 1 for quality.
        if award.expires_in > 0 
          award.quality += 1 
          award.expires_in -= 1
        ## However less than zero, we increment by 2 
        elsif award.expires_in <= 0 
          # Less than zero we know we need to increment quality by two times the usual. 
          if award.quality < 50 
            award.expires_in -= 1 
            ## This edge case captures instances where we do not want to increment quality past 50 (Since 50 is capped) ex: 49 
            award.quality = [award.quality += 2, 50].min
          end 
        end 
      ## Capures edge case for when award.quality is capped already (at 50) but we still need to decrement our expiration dates. 
      else 
        award.expires_in -= 1 
      end

    ## Blue Distinction Plus do not change. 
    when "Blue Distinction Plus"  
      
    ## Blue compares quality increase by 2 when expiration is between 6 and 10, 3 when less than 10 and at zero or less it resets to zero
    when "Blue Compare"
      ## covers cases for when quality is between 1 and 49 
      if award.quality < 50 && award.quality > 0 
        ## if expiration date is greater than 0 we know we have to change the quality.
        if award.expires_in > 0 
          ## if expiration is between 6 to 10 days, increment by 2 
          if award.expires_in >= 6 && award.expires_in <= 10
            award.quality += 2 
            award.expires_in -= 1 
          ## if expiration is between 1 to 5 days, increment by 3 
          elsif award.expires_in <= 5 
            award.quality += 3
            award.expires_in -= 1  
          ## if expiration is greater than 10 days, increment quality normally by 1 
          elsif award.expires_in > 10 
            award.expires_in -= 1 
            award.quality += 1 
          end
        ## if expiration is zero or less, we know we still have to decrement the expires_in but quality is set to zero. (Potential opitmization here? setting to zero)  
        elsif award.expires_in <= 0
          award.quality = 0
          award.expires_in -= 1 
        ## if quality is capped we still have to decrement. 
        elsif award.quality == 50
          award.expires_in -= 1 
        end
      ## covers case for when quality is at 50 and thus the only thing to change is the expires in.   
      else 
        award.expires_in -= 1   
      end 
    ## Blue star traits. Quality degrades twice as fast as a normal item.Quality -= 2 (Including when expires_in is less than or equal to zero) Qual -= 4 
    when "Blue Star"
      ## if quality is greater than 0 and expires_in is greater than zero (We change quality and expires in)
      if award.quality > 0 && award.expires_in > 0 
        award.quality -= 2 
        award.expires_in -= 1 
      ## if quality is equal to zero, we still need to decrement expires_in.
      elsif award.quality == 0 
        award.expires_in -= 1 
      ## if expires in less than or equal to zero it degrades twice as fast as a normal item (x4)
      elsif award.expires_in <= 0 
        award.quality -= 4 
        award.expires_in -= 1 
      end 
    ## Normal item traits quality -= 1 and -= 2 past expiration.  
    when "NORMAL ITEM" # when normal award.
      ## When quality is greater than zero and expires in is greater than 0 we follow normal decrementation of quality (x1) 
      if award.quality > 0 && award.expires_in > 0
        award.quality -= 1 
        award.expires_in -= 1 
      ## Otherwise past expiration we decrement twice as fast.   
      elsif award.expires_in <= 0 
        award.quality -= 2 
        award.expires_in -= 1 
      ## in instance where quality == 0 still need to decrement by 0 ## Question can we somehow make this more DRY since all awards have this trait.
      elsif award.quality == 0 
        award.expires_in -= 1 
      end 
    end
    ## Additional notes, the NORMAL ITEM and Blue Star need a test case to ensure quality does not go below zero. This could happen for normal item when
    ## quality is at 1 and expires_in is at zero. In this case quality would be -1. Similar cases are present for Blue Star since it is not decrementing by 1. 
    ## Blue care also needs testing for when incrementing to ensure quality does not go past 50 
  end 
end

