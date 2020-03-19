## Blue compares quality increase by 2 when expiration is between 6 and 10, 3 when less than 10 and at zero or less it resets to zero
def update_blue_compare(award)
    ## covers cases for when quality is between 1 and 49 
    if award.quality < 50 && award.quality > 0 
        ## if expiration date is greater than 0 we know we have to change the quality.
        if award.expires_in > 0 
          ## if expiration is between 6 to 10 days, increment by 2 
          if award.expires_in >= 6 && award.expires_in <= 10
            award.quality = [award.quality += 2, 50].min
            award.expires_in -= 1 
          ## if expiration is between 1 to 5 days, increment by 3 
          elsif award.expires_in <= 5 
            award.quality = [award.quality += 3, 50].min
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
end 