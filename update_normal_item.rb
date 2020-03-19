## Normal item traits quality -= 1 and -= 2 past expiration.  
def update_normal_item(award) 
    ## When quality is greater than zero and expires in is greater than 0 we follow normal decrementation of quality (x1) 
    if award.quality > 0 && award.expires_in > 0 
        award.quality -= 1 
        award.expires_in -= 1 
      ## Otherwise past expiration we decrement twice as fast.   
      elsif award.expires_in <= 0 
        ## ensures quality does not go past zero. 
        award.quality = [award.quality -= 2, 0].max
        award.expires_in -= 1 
      ## in instance where quality == 0 still need to decrement by 0 ## Question can we somehow make this more DRY since all awards have this trait.
      elsif award.quality == 0 
        award.expires_in -= 1 
      end 
end 