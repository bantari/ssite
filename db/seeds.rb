#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

puts "--- create SYSTEM user"
User.create(
  :name                   => '=SYSTEM=',
  :description            => 'For performing automatic system/scripted actions',
  :email                  => 'system@stemgent.com',
  :password               => 'fluffy',
  :password_confirmation  => 'fluffy',
  :admin                  => true,
  :editable               => false
)
puts "--- create ADMIN user"
User.create(
  :name                   => '=ADMIN=',
  :email                  => 'admin@stemgent.com',
  :password               => 'fluffy',
  :password_confirmation  => 'fluffy',
  :admin                  => true,
  :editable               => false
)

#--------------------------------------------------------------------------------------------------------------------------------

puts "--- create categories - base"
stg = Category.create(:name=>'Stemgent')
Category.create(:parent_id=>stg.id, :name=>'Antibodies')
Category.create(:parent_id=>stg.id, :name=>'Cell Lines')
Category.create(:parent_id=>stg.id, :name=>'Cytokines', :title=>'Cytokines / Proteins')
Category.create(:parent_id=>stg.id, :name=>'Matrices')
Category.create(:parent_id=>stg.id, :name=>'Reprogramming', :title=>'Reprogramming Systems')
Category.create(:parent_id=>stg.id, :name=>'Small Molecules')
Category.create(:parent_id=>stg.id, :name=>'Transfection')

puts "--- create categories - applications"
apl = Category.create(:name=>'Application')
Category.create(:parent_id=>apl.id, :name=>'Reprogramming')
Category.create(:parent_id=>apl.id, :name=>'Self-Renewal')
Category.create(:parent_id=>apl.id, :name=>'Differentiation')

puts "--- create categories - speciels"
spc = Category.create(:name=>'Species')
Category.create(:parent_id=>spc.id, :name=>'Human')
Category.create(:parent_id=>spc.id, :name=>'Mouse')
Category.create(:parent_id=>spc.id, :name=>'Rabbit')
Category.create(:parent_id=>spc.id, :name=>'Rat')

puts "=== reseting trace for all categories"
Category.all.each do |cat|
  cat.reset_trace
end # do categories

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
