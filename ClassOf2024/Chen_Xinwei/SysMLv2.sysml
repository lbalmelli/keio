package Concept {
	package 'Shooting Game Concept Model' {
		part def GameEnvironment {
			doc /* GameEnvironment is the primary context for the shooting game, containing all essential 
			            parts (Player, Weapon, Target) and interfaces that define the gameplay interactions. 
			            It orchestrates the connection between Player and Weapon, as well as Weapon and Target, 
			            ensuring that the game actions are carried out according to the defined rules. */
			part player : Player;
			part weapon;
			part target;
			interface playerToWeapon {
				doc /* playerToWeapon connects the Player's trigger action to the Weapon's firing mechanism,                 enabling the Player to shoot through the Weapon. This interface ensures that the Player's trigger action successfully initiates the firing sequence in the Weapon. */
			}
			interface weaponToTarget {
				doc /* weaponToTarget connects the Weapon's bullet to the Target's hit area, providing the  mechanism to detect when a fired bullet hits the Target. This interface is critical for implementing hit detection, which enables the game to respond appropriately when the Target is hit. */
			}
			action gameLoop {
				doc /* gameLoop defines the primary sequence of actions that occur during gameplay. 
				                It begins with starting the game, proceeds to check if a hit occurred, 
				                updates the score if a hit is detected, and loops until the game ends. */
				action startGame;
				action checkHit;
				action updateScore;
				action;
				action;
			}
		}
		part def Player {
			doc /* Player represents the main character or user-controlled entity within the game. 
			            The Player interacts with the Weapon to shoot at Targets and has a health attribute 
			            that could be used for player endurance or survival mechanics. */
			attribute health = 100;
			action def triggerFire {
				doc /* triggerFire is the action that the Player performs to initiate a shot. 
				                It acts as the initial trigger, which then activates the Weapon?s firing mechanism. */
			}
		}
	}
}
package PoC {
	package 'Shooting Game POC' {
		part def GameEnvironment {
			doc /* GameEnvironment POC contains the basic parts (Player, Weapon, Target) 
			            and establishes their core interactions for a proof of concept. */
			part player : Player;
			part weapon : Weapon;
			part target;
			interface playerToWeapon;
			interface weaponToTarget;
		}
		part def Player {
			doc /* The Player in this POC can trigger the weapon to fire but has no health management. */
			action def triggerFire {
				doc /* Action to initiate firing from the Weapon. */
			}
		}
		part def Weapon {
			doc /* The Weapon in this POC has basic firing capability and limited ammo tracking. */
			attribute ammo = 5;
			action def trigger {
				doc /* Action to shoot a bullet if ammo is available. */
			}
		}
	}
}
package Package {
	package 'Requirements and Use Case' {
		package 'Game Requirements' {
			requirement def <R1> FireWeaponRequirement {
				doc /* The player shall be able to fire the weapon if there is ammunition available. */
				subject player;
				subject weapon;
				attribute ammoAvailable = >;
				constraint;
			}
			requirement def <R2> HitDetectionRequirement {
				doc /* The weapon shall detect when a fired bullet hits the target. */
				subject weapon;
				subject target;
				constraint;
				intersects;
				target;
			}
		}
	}
}