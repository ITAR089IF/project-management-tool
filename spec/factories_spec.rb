FactoryBot.define do
	factory :workspace do
		name { 'Test workspace' }
	end

	factory :user do
		full_name { 'Jon Doe' }
		email { 'jon.doe@email.com' }
		password { '123456' } 
	end
end
