namespace :db do
  desc "Create users"
  task create_users: :environment do
    User.create!(firstname: "Martin",
                 lastname: "Paríža",
                 name_suffix: "",
                 email: "martin.pariza@live.com",
                 phone_nr: "0907847996",
                 password: "papagaj",
                 password_confirmation: "papagaj",
                 admin: true,
                 residence: "Trstená",
                 year_of_birth: 1980
    )
    
    User.create!(firstname: "Tomáš",
                 lastname: "Radič",
                 name_suffix: "",
                 email: "tomas.radic@gmail.com",
                 phone_nr: "0905289248",
                 password: "papagaj2",
                 password_confirmation: "papagaj2",
                 admin: false,
                 residence: "Topoľčany",
                 year_of_birth: 1980
    )
  end


  desc "Create matches"
  task create_matches: :environment do
    Match.create!(date_of_play: "2014-05-20",
                  name: "",
                  note: "",
                  min_num_of_players: 10,
                  max_num_of_players: 14,
                  completed: true
    )

    Match.create!(date_of_play: "2014-07-20",
                  name: "",
                  note: "",
                  min_num_of_players: 10,
                  max_num_of_players: 14,
                  completed: false
    )
    
  end


  desc "Create match subscriptions"
  task create_match_subscriptions: :environment do
    MatchSubscription.create!(user_id: 1,
                              match_id: 2
    )
    MatchSubscription.create!(user_id: 1,
                              match_id: 14
    )

    
  end
end
