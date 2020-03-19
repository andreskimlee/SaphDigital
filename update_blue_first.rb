## Blue first traits. Quality += 1 when expires_in > 0 and Quality += 2 when expires_in <= 0 
def update_blue_first(award)
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
end 