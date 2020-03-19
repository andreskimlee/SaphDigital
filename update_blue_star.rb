## Blue star traits. Quality degrades twice as fast as a normal item.Quality -= 2 
## (Including when expires_in is less than or equal to zero) Qual -= 4 
def update_blue_star(award) 
    ## if quality is greater than 0 and expires_in is greater than zero (We change quality and expires in)
    if award.quality > 0 && award.expires_in > 0 
        award.quality = [award.quality -= 2, 0].max
        award.expires_in -= 1 
      ## if quality is equal to zero, we still need to decrement expires_in.
      elsif award.quality == 0 
        award.expires_in -= 1 
      ## if expires in less than or equal to zero it degrades twice as fast as a normal item (x4)
      elsif award.expires_in <= 0 
        award.quality = [award.quality -= 4, 0].max
        award.expires_in -= 1 
      end 
end 