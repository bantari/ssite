class AccessMatrix
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def visible_items_for(usr)
    arr = []
    
    #--- document objects
    arr += [:documents,:publications] if self.documents
    arr += [:document_types]          if self.documents && self.system
    
    #--- inventory objects
    arr += [:skus,:courses,:products] if self.inventory
    arr += [:brands,:categories]      if self.inventory && self.live

    #--- website objects
    arr += [:pages,:forms]            if self.website
    arr += [:bubbles,:snipplets]      if self.website
    arr += [:page_types]              if self.website && self.system
    arr += [:glossary]                if self.web_glossary
    arr += [:social]                  if self.web_social
    arr += [:faq]                     if self.web_faq

    #--- media objects
    arr += [:images,:videos]          if self.media

    #--- admin objects
    arr += [:users]                   if self.admin

    return arr
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end