class Pokemon
  
  attr_accessor :id, :name, :type, :db
  
  def initialize(id:, name:, type:, db:)
    #binding.pry 
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?,?)"
    
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    
  end
  
  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ? LIMIT 1"
    db.execute(sql, id).map do |row|
      Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
    end.first    
  end
  
end
