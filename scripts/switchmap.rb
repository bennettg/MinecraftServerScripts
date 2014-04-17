require 'fileutils'
require 'colorize'

$countS=1
$serverLocation = 'C:/Users/Bennett/mc-server/'
$mapDir= 'maps/'
$serverMaps = $serverLocation + $mapDir
$serverProperties = $serverLocation + 'server.properties'

def getCurrentSeed ()
	currentSeed = read_one_line($serverProperties,14)
	cs = currentSeed.sub("level-seed=","")
	cs= cs.gsub(/\s+/, "")
	return cs
end

def getCurrentWorld (clearDir)
	currentWorld = read_one_line($serverProperties,6)
	currentWorld = currentWorld.sub("level-name=","")
	cw = (clearDir == true ? currentWorld.sub($mapDir,"") : currentWorld)
	cw= cw.gsub(/\s+/, "")
	return cw
end

def setSeed(seed)
	currentSeed=getCurrentSeed
	new_seed=seed
	File.open($serverProperties, 'r+') { |f| newstr = f.read.gsub('level-seed='+currentSeed+'','level-seed='+new_seed); f.rewind; f.puts(newstr) }
end

def clearOldSeeds ()
	currentSeed=getCurrentSeed
	new_seed=""
	File.open($serverProperties, 'r+') { |f| newstr = f.read.gsub('level-seed='+currentSeed+'','level-seed='+new_seed); f.rewind; f.puts(newstr) }
end

def read_one_line(file_name, line_number)
  File.open(file_name) do |file|
    current_line = 1
    file.each_line do |line|
      return line if line_number == current_line
      current_line += 1
    end
  end
end

def newLine 
	puts"\n"
end

def createNewWorld ()
	
	puts 'What would you like to call this new world?'
	userMap=gets.chomp
		putSmallGap
	setWorld(userMap,new=true)
		putSmallGap
	puts 'Would you like to set a new seed for this world? blank= no'
	userSeed=gets.chomp
		
			setSeed(userSeed)
	
	#system($serverLocation+"run.bat")
	puts'Restart the server to generate the new map'
end

def setWorld(worldName,new)
	if !new==true then puts 'finding world..' end
	new_worldName=$mapDir + worldName;
	if !worldName.empty? then 
		if new==true then puts "inserted world..." else puts "found world..." end
	end
	currentWorld = getCurrentWorld(false)
	File.open($serverProperties, 'r+') { |f| newstr = f.read.gsub('level-name='+currentWorld+'','level-name='+new_worldName); f.rewind; f.puts(newstr) }
	puts "the server world has been set to #{new_worldName}"
end

def putLargeGap
   i=1
   num=5
   while i < num  do
		newLine
	   i +=1
	end
end

def putSmallGap 
	i=1
	num=3
	while i < num do 
		newLine
		i +=1
	end
end

def putLoading 
	puts "Loading...."

end

def putError
	## beginline
	puts "===========ERROR=============="
	## nextline
end

def putAProcess 
	putLoading						
	sleep(1)
	putLargeGap
end


	$worldsin=Array.new
currentWorld=getCurrentWorld(true)
	newLine
	newLine
	puts "List of available worlds to switch to... \n"
	puts "============================================"
	newLine
	FileUtils.cd($serverMaps)
		countn=1
	Dir.glob('*').select { |f| 
		unless f == currentWorld then 
			puts "[#{countn}]"+f 
			$worldsin << f
			countn=(countn+1) 
		end
		
	}
	
	

		def askSwitch(occur)	
		newLine
			case occur
				when 1 
					puts ">> What world would you like to switch to? Or enter 'mkworld' to set a new one :3 \n".yellow
				when 2
					puts ">> What is the world you want to switch to?".yellow
				when 3
					puts ">> Please tell me the correct name of the world you would like to switch over to.".yellow
					$gotCorrectFinally=true
				when 4
					puts "Alright, What is your name young man (or lady)? >:(".yellow
						$userName=gets.chomp
					puts ">> #{$userName}, I am not going to ask you again, make the correct switch to the world of your desire or else".yellow
				when 5
					puts ">> Wow. Just enter the damn world and stop trying to piss me off".yellow
				when 6
					puts ">> Seriously, enter a world that exists for heaven sakes.".yellow
				when 7 
					puts ">> What part of \"Enter a world that exists\" do you not understand?".yellow
				when 8
					puts " t( - __ - ) "
				when 9
					putLargeGap
						puts "Holy crap what is wrong with you!? Are you trying to piss me off!?".yellow
					sleep(2)
				when 10
					putLargeGap
						puts ">> Nope. Just no. I will not be penetrated any longer by your insults.".yellow
					sleep(2)
						puts "Goodbye Idiot."
					sleep(1.2)
					exit
				end
			userWorld=gets.chomp
				putAProcess
			if userWorld=="mkworld"
				createNewWorld()
			elsif !$worldsin.include? userWorld
					unless $countS > 1 then putError 
						puts "The world you entered does not exist in the maps directory. Please choose one that does"
					end
				$countS+=1
				askSwitch($countS)
			else
				if $gotCorrectFinally then puts "That's more like it. Thanks." end
				setWorld(userWorld,new=false)
			end
		end
		
		askSwitch($countS)
eend = gets.chomp
