require "sqlite3"

class Seeder

    def self.seed!

        db = connect
        drop_tables(db)
        create_tables(db)
        populate_tables(db)

    end

    def self.connect

        SQLite3::Database.new 'DB/database.db'

    end

    def self.drop_tables(db)

        db.execute('DROP TABLE IF EXISTS users')
        db.execute('DROP TABLE IF EXISTS posts')
        db.execute('DROP TABLE IF EXISTS comments')
        db.execute('DROP TABLE IF EXISTS post_gbp')

    end

    def self.create_tables(db)

        db.execute <<-SQL
            CREATE TABLE "users" (
                "Email"     TEXT NOT NULL UNIQUE COLLATE NOCASE,
                "ID"        INTEGER PRIMARY KEY AUTOINCREMENT,
                "Name"      TEXT NOT NULL UNIQUE,
                "Password"  TEXT NOT NULL,
                "GBP"       INTEGER NOT NULL DEFAULT 0

            );
        SQL

        db.execute <<-SQL
            CREATE TABLE "comments" (
                "ID"        INTEGER PRIMARY KEY AUTOINCREMENT,
                "GBP"       INTEGER NOT NULL DEFAULT 0,
                "Parent_id" INTEGER,
                "Comment"   TEXT NOT NULL

            );
        SQL

        db.execute <<-SQL
            CREATE TABLE "posts" (
                "ID"         INTEGER PRIMARY KEY AUTOINCREMENT,
                "GBP"        INTEGER NOT NULL DEFAULT 0,
                "Picture_id" TEXT UNIQUE,
                "Text"       TEXT NOT NULL COLLATE NOCASE,
                "Title"      TEXT NOT NULL COLLATE NOCASE,
                "User_id"    INTEGER NOT NULL 
            
            );
        SQL

        db.execute <<-SQL
            CREATE TABLE "post_gbp" (
                "ID"	INTEGER PRIMARY KEY AUTOINCREMENT,
                "User_id"	INTEGER NOT NULL,
                "Post_id"	INTEGER NOT NULL
            );
        SQL

    end

    def self.populate_tables(db)

        users = [
            
            {Email:"Jesper.storberg@fleshbook.br", Name: "JessGore420", Password: "asjhyujgvtyhujikhgvtyhuj", GBP:2},
            {Email:"Hungman@hotmail.se", Name: "Hungman", Password: "jvnknhjbhyujnhnb", GBP:-5},
            {Email:"Marcus_admaner", Name: "InnocentBoi99", Password: "bvcdrtyuikjmnb", GBP:56},
            {Email:"Potatolover@gmail.com", Name: "Hotp0tato", Password: "zsdertyuiol", GBP:5},
            {Email:"Weeb@weebmail.jp", Name: "Animelover69Weebz", Password: "xcvbnmkidearfj", GBP:-25},
            {Email:"Adam@adam.com", Name: "Adam", Password: "frtyuioladammnbv", GBP:3},
        ]

        comments = [
            {GBP: 3, Parent_id: nil, Comment: "Nice eyes on the floor" }
        ]

        posts = [
            {GBP: 5, Picture_id: "asdf2678fi7", Text: "This is my new decoration", Title: "Halloween", user_id: 1 }
        ]

        users.each do |user| 
            db.execute("INSERT INTO users (Email, Name, Password) VALUES(?,?,?)", user[:Email].downcase(), user[:Name], user[:Password])
        end   

        posts.each do |post|
            db.execute("INSERT INTO posts (Picture_id, Text, Title, user_id) VALUES(?,?,?,?)", post[:Picture_id], post[:Text], post[:Title], post[:user_id])
        end

        comments.each do |comment|
            db.execute("INSERT INTO comments (Parent_id, Comment) VALUES(?,?)", comment[:Parent_id], comment[:Comment])
        end
    end
end

Seeder.seed!