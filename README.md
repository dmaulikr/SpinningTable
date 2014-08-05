#Spinning Table

##iOS Game: Spinning Table
* This simple game was created for the purpose of getting familiar with Swift and SpriteKit

####Language:
* Swift

####Frameworks/tools:
* SpriteKit
* UIKit
* Foundation

####General Rules:
* Each time the screen is touched, the Player will jump to the inner loop
* Eating a Star gains you two points
* Eating a Heart gains you one point as well as a Life
* Touching a Shuriken leads you to Game Over, or decreases your Life count (if you have more than 0 Life)
* Running out of the map also leads you to Game Over
* Level increases as you gain more points, the speed at which the Players move/spin at increases as the level increases
* You may click Replay or Share the results on social media

####Known Issues:
If you're using Xcode6 Beta3:
* When you first run the game, you might (or might not) encounter an error that says: "thread 1:EXC_BREAKPOINT (code=EXC_i386_BPT, subcode=0x0)" 
The solution to this is to do Product -> Clean

If you're using Xcode6 Beta4:
* "'CGFloat' is not convertible to 'NSTimeInterval'" is an error that might occur, a temporary solution is to cast the variable into "Double", at the lines that are failing
* The path created using SKShapeNode does not show up (this issue doesn't occur in Beta3)
Good to know that I am not the only one that's seeing this issue': http://stackoverflow.com/questions/24951185/in-xcode-6-beta-4-stroking-with-skshapenode-doesnt-work-anymore & https://devforums.apple.com/message/1011007#1011007
No good solutions have been found for the above issues, yet.