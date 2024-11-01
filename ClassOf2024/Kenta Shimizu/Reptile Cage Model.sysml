package Package {
	package 'Environmental Control Reptile Cage Context' {
		part def atmosphere {
			attribute temperature : ScalarValues::Real;
			attribute humidity : ScalarValues::Real;
			doc /*     part def ReptileCage {
			        doc /*
			         * Defines the reptile cage with internal temperature and humidity attributes,
			         * and includes components for monitoring and controlling these attributes.
			         */
			        
			        attribute temperature: ScalarValues::Real;
			        attribute humidity: ScalarValues::Real;
			        part temperatureController: TemperatureControlUnit;
			        part humidityController: HumidityControlUnit;
			        part sensor: TempHumiditySensor;
			        part controlUnit: ControlSystem;
			    }
			 */
		}
		part def ReptileCage {
			attribute temperature : ScalarValues::Real;
			attribute humidity : ScalarValues::Real;
			part temperatureController : TemperatureControlUnit {
				in port port;
				in port 'tc_Elecrtic Poiwer_in';
				out port port;
			}
			part humidityController : HumidityControlUnit {
				in port port;
				in port 'hs_Elecrtic Poiwer_in';
				out port port;
			}
			part sensor : TempHumiditySensor {
				out port 'Control Command_out';
				in port Temp_THS_in;
				in port 'Electric Power_in';
				in port Humidity_THS_in;
			}
			part controlUnit : ControlSystem {
				in port 'Control Command_in';
				out port port;
				out port port;
				in port 'cs_Elecrtic Poiwer_in';
			}
			in port Humidity;
			in port Temperature;
			out port port;
			out port port;
			in port 'Electric Power';
			doc /* part def ReptileCage {
			    attribute temperature: ScalarValues::Real;
			    attribute humidity: ScalarValues::Real;
			    part temperatureController: TemperatureControlUnit;
			    part humidityController: HumidityControlUnit;
			    part sensor: TempHumiditySensor;
			    part controlUnit: ControlSystem;
			} */
			part Cage : Cage;
		}
		part def Reptile {
			doc /*     part def ReptileCage {
			        doc /*
			         * Defines the reptile cage with internal temperature and humidity attributes,
			         * and includes components for monitoring and controlling these attributes.
			         */
			        
			        attribute temperature: ScalarValues::Real;
			        attribute humidity: ScalarValues::Real;
			        part temperatureController: TemperatureControlUnit;
			        part humidityController: HumidityControlUnit;
			        part sensor: TempHumiditySensor;
			        part controlUnit: ControlSystem;
			    }
			 */
		}
		part context {
			part atmosphere : atmosphere {
				inout port 'ae_Air inout';
				doc /*     // Definitions for elements in the environment
				    part def Atmosphere {
				        doc /*
				         * Represents the surrounding air with attributes for temperature and humidity.
				         */
				        
				        attribute temperature: ScalarValues::Real;
				        attribute humidity: ScalarValues::Real;
				    } */
			}
			part cage : ReptileCage {
				inout port rc_Air_inout;
				out port 'rc_conditioned air_out';
				in port 'rc_electrical power_in';
				doc /*     part def ReptileCage {
				        doc /*
				         * Defines the reptile cage with internal temperature and humidity attributes,
				         * and includes components for monitoring and controlling these attributes.
				         */
				        
				        attribute temperature: ScalarValues::Real;
				        attribute humidity: ScalarValues::Real;
				        part temperatureController: TemperatureControlUnit;
				        part humidityController: HumidityControlUnit;
				        part sensor: TempHumiditySensor;
				        part controlUnit: ControlSystem;
				    } */
			}
			part reptile : Reptile {
				in port 're_conditioned air_in';
			}
			part 'Power Supply' : 'Power Supply' {
				out port 'ps_electrical power_out';
			}
		}
		part def TempHumiditySensor {
			perform  {
				temperature : ScalarValues::Real;
			}
			perform  {
				humidity : ScalarValues::Real;
			}
		}
		part def ControlSystem {
			perform  {
				measuredTemperature : ScalarValues::Real;
			}
			perform  {
				measuredHumidity : ScalarValues::Real;
			}
		}
		part def TemperatureControlUnit {
			action heatAir {
				/* Heats the air */
			}
			action coolAir {
				/* Cools the air */
			}
		}
		part def HumidityControlUnit {
			action dehumidify {
				/* Removes moisture */
			}
			action humidify {
				/* Adds moisture */
			}
		}
		package 'Control Behaviors' {
			import ;
		}
		part def 'Power Supply';
		package 'Environmental Control Reptile Cage Context' {
			doc /* * This package models an environmental control system for a reptile cage, 
			     * ensuring optimal conditions for reptile health by controlling temperature 
			     * and humidity. The model includes definitions of environmental elements, 
			     * sensors, and control units, along with behavior to adjust conditions 
			     * based on real-time data. */
			part def Air {
				doc /* * Represents the surrounding air with attributes for temperature and humidity. */
				attribute temperature : ScalarValues::Real;
				attribute humidity : ScalarValues::Real;
			}
			part def ReptileCage {
				doc /* * Defines the reptile cage with internal temperature and humidity attributes,
				         * and includes components for monitoring and controlling these attributes. */
				attribute temperature : ScalarValues::Real;
				attribute humidity : ScalarValues::Real;
				part temperatureController : TemperatureControlUnit;
				part humidityController : HumidityControlUnit;
				part sensor : TempHumiditySensor;
				part controlUnit : ControlSystem;
			}
			part def Reptile {
				doc /* * Represents a reptile as an occupant of the controlled environment. */
			}
			part context {
				doc /* * Contextual setup defining the interaction between the reptile cage and its
				         * surrounding air. Includes temperature and humidity exchange between 
				         * the air and the cage. */
				part air : Air;
				part cage : ReptileCage;
				part reptile : Reptile;
				action airToCage_Heat;
				action airToCage_Humidity;
			}
			part def TempHumiditySensor {
				doc /* * Sensor part for measuring the cages temperature and humidity levels. */
				perform  {
					doc /* * Measures the current temperature within the cage. */
					temperature : ScalarValues::Real;
				}
				perform  {
					doc /* * Measures the current humidity within the cage. */
					humidity : ScalarValues::Real;
				}
			}
			part def ControlSystem {
				doc /* * A control system part that adjusts temperature and humidity levels based on 
				         * data from sensors. */
				perform  {
					doc /* * Controls temperature adjustment actions based on measured temperature. */
					measuredTemperature : ScalarValues::Real;
				}
				perform  {
					doc /* * Controls humidity adjustment actions based on measured humidity. */
					measuredHumidity : ScalarValues::Real;
				}
			}
			part def TemperatureControlUnit {
				doc /* * Device responsible for adjusting the cage?s temperature, capable of both 
				         * heating and cooling the air. */
				action heatAir {
					doc /* * Heats the air within the cage. */
				}
				action coolAir {
					doc /* * Cools the air within the cage. */
				}
			}
			part def HumidityControlUnit {
				doc /* * Device for adjusting the cages humidity level by either adding or 
				         * removing moisture. */
				action dehumidify {
					doc /* * Reduces the humidity by removing moisture from the air. */
				}
				action humidify {
					doc /* * Increases humidity by adding moisture to the air. */
				}
			}
			package 'Control Behaviors' {
				import ;
				doc /* * Behavioral model for monitoring and adjusting cage conditions. Defines 
				         * state-based processes for temperature and humidity control. */
			}
		}
		part def Cage;
	}
}
package PoC {
	package 'Enhanced Environmental Control Reptile Cage PoC' {
		import context::cage::*;
		doc /* * This package defines an enhanced Proof of Concept (PoC) model for an environmental
		     * control system within an Exo Terra Glass Terrarium 3090. The model includes a single
		     * Arduino to manage both temperature and humidity levels based on feedback from DHT22
		     * sensors. It also integrates an external power supply and considers the influence of
		     * external air on the cages internal environment. */
		part def ExternalAir {
			doc /* * Represents the external air surrounding the cage, with attributes for temperature and humidity. */
			attribute temperature : ScalarValues::Real;
			attribute humidity : ScalarValues::Real;
		}
		part def InternalAir {
			doc /* * Represents the internal air within the cage, with attributes for temperature and humidity. */
			attribute temperature : ScalarValues::Real;
			attribute humidity : ScalarValues::Real;
		}
		part def ReptileCage {
			doc /* * Defines the reptile cage as an Exo Terra Glass Terrarium 3090, with temperature and humidity control. */
			attribute temperature : ScalarValues::Real;
			attribute humidity : ScalarValues::Real;
			part cageBody : CageStructure {
				inout port 'Interfacial Force_inout';
				inout port 'Interfacial Force_inout';
			}
			part controlSystem : IntegratedControlSystem {
				inout port 'Interfacial Force_inout';
				in port 'Control Command_in';
				out port ConditionedAir_out;
				in port Air_in;
				in port 'Electric Power_in';
			}
			part sensor : TempHumiditySensor {
				in port Air_in;
				inout port 'Interfacial Force_inout';
				out port 'Control Command_out';
				in port 'Electric Power_in';
			}
			out port port : ConditionedAir_out;
			in port port : Air_in;
			in port port : 'Electric Power_in';
		}
		part def CageStructure {
			doc /* * Represents the main physical structure of the Exo Terra Glass Terrarium 3090,
			         * providing a contained environment for temperature and humidity control. */
		}
		part def Reptile {
			doc /* * Represents a reptile as an occupant of the controlled environment. */
		}
		part def PowerSupply {
			doc /* * Provides electrical power to the control system, enabling the operation of heating, cooling,
			         * humidifying, and dehumidifying devices. */
			power : ScalarValues::Real;
		}
		part context : InternalAir {
			doc /* * Contextual setup defining the interaction between the reptile cage, external air, 
			         * and power supply. External air influences the cages internal environment,
			         * while the power supply supports device operation within the cage. */
			part externalAir : ExternalAir {
				inout port Air_inout;
				out port Air_out;
			}
			part internalAir : InternalAir {
				inout port Air_inout;
				in port ConditionedAir_in;
				out port port;
			}
			part cage : ReptileCage {
				in port 'Electric Power_in';
				out port ConditionedAir_out;
				in port Air_in;
			}
			part reptile : Reptile {
				in port port;
			}
			part powerSupply : PowerSupply {
				out port 'Electric Power_out';
			}
			action powerFlow;
			action externalToInternal_Heat;
			action externalToInternal_Humidity;
		}
		part def TempHumiditySensor {
			doc /* * Sensor part using DHT22 to measure the cages temperature and humidity levels. */
			perform  {
				doc /* * Measures the current temperature within the cage. */
				temperature : ScalarValues::Real;
			}
			perform  {
				doc /* * Measures the current humidity within the cage. */
				humidity : ScalarValues::Real;
			}
		}
		part def IntegratedControlSystem {
			doc /* * Integrated system for controlling both temperature and humidity, using a single Arduino 
			         * to manage heating, cooling, humidifying, and dehumidifying devices based on sensor feedback. */
			powerInput : ScalarValues::Real;
			perform  {
				measuredTemperature : ScalarValues::Real;
				measuredHumidity : ScalarValues::Real;
			}
			part heater : GEX_ExoTerraHeatingTop {
				doc /* * GEX EXOTERRA Heating Top for increasing temperature when below the target. */
			}
			part cooler : PeltierCoolingUnit {
				doc /* * Peltier Cooling Unit with fan to decrease temperature when above the target. */
			}
			part humidifier : ZensuiFog {
				doc /* * Zensui Fog device for adding moisture to the air when humidity is below target. */
			}
			part fan : GexFan {
				doc /* * GEX fan for circulating air to reduce humidity when above the target. */
			}
		}
		part def GEX_ExoTerraHeatingTop {
			action heatAir {
				doc /* * Heats the air within the cage using GEX EXOTERRA Heating Top. */
			}
		}
		part def PeltierCoolingUnit {
			action coolAir {
				doc /* * Cools the air within the cage using a Peltier element and attached fan. */
			}
		}
		part def ZensuiFog {
			action humidify {
				doc /* * Adds moisture to the cage air using the Zensui Fog device. */
			}
		}
		part def GexFan {
			action dehumidify {
				doc /* * Circulates air to decrease humidity in the cage using the GEX fan. */
			}
		}
		package 'Control Behaviors' {
			doc /* * Behavioral model for monitoring and adjusting cage conditions with a single control system.
			         * Defines state-based processes for integrated temperature and humidity control. */
		}
	}
}