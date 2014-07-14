namespace :db do
  
  desc "Create statuses"
  task create_statuses: :environment do
    Status.create!(name: "nový")
    Status.create!(name: "aktívny")
    Status.create!(name: "zablokovaný")
  end



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
                 year_of_birth: 1980,
                 plays_since: 1990,
                 status_id: 2
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
                 year_of_birth: 1980,
                 plays_since: 1995,
                 status_id: 2
    )

    User.create!(firstname: "Miloš",
                 lastname: "Jánoš",
                 name_suffix: "",
                 email: "milos.janos@gmail.com",
                 phone_nr: "0905111222",
                 password: "papagaj2",
                 password_confirmation: "papagaj2",
                 admin: false,
                 residence: "Sklené Teplice",
                 year_of_birth: 1980,
                 plays_since: 1992,
                 status_id: 2
    )

    User.create!(firstname: "Palo",
                 lastname: "Hajník",
                 name_suffix: "",
                 email: "pali5@centrum.sk",
                 phone_nr: "0905222333",
                 password: "papagaj2",
                 password_confirmation: "papagaj2",
                 admin: false,
                 residence: "Vranov n. Topľou",
                 year_of_birth: 1980,
                 plays_since: 1998,
                 status_id: 2
    )

    User.create!(firstname: "Michal",
                 lastname: "Hárar",
                 name_suffix: "",
                 email: "michal.harar@gmail.com",
                 phone_nr: "0905333444",
                 password: "papagaj2",
                 password_confirmation: "papagaj2",
                 admin: false,
                 residence: "Trenčín",
                 year_of_birth: 1981,
                 plays_since: 1994,
                 status_id: 2
    )

  end


  desc "Create categories"
  task create_categories: :environment do
    Category.create!(name: "zápas")
    Category.create!(name: "tréning")
  end

  

  desc "Create matches"
  task create_matches: :environment do
    Match.create!(date_of_play: "2014-05-20",
                  category_id: 1,
                  name: "Prvý zápas sezóny",
                  note: "",
                  min_num_of_players: 10,
                  max_num_of_players: 16
    )

    Match.create!(date_of_play: "2014-06-16",
                  category_id: 2
    )
    

    Match.create!(date_of_play: "2014-07-20",
                  category_id: 2,
                  note: "Tréning na zápas o halušky.",
                  min_num_of_players: 6
    )

    Match.create!(date_of_play: "2014-07-23",
                  category_id: 1,
                  name: "Zápas o halušky v Josu",
                  note: "",
                  min_num_of_players: 10,
                  max_num_of_players: 16
    )


    
  end


  desc "Create match subscriptions"
  task create_match_subscriptions: :environment do
    MatchSubscription.create!(
        user_id:  1,
        match_id: 1
    )

    MatchSubscription.create!(
        user_id:  2,
        match_id: 1
    )

    MatchSubscription.create!(
        user_id:  3,
        match_id: 1
    )

    MatchSubscription.create!(
        user_id:  4,
        match_id: 1
    )

    MatchSubscription.create!(
        user_id:  5,
        match_id: 1
    )

    MatchSubscription.create!(
        user_id:  1,
        match_id: 2
    )

    MatchSubscription.create!(
        user_id:  3,
        match_id: 2
    )

    MatchSubscription.create!(
        user_id:  5,
        match_id: 2
    )


    
  end
end
