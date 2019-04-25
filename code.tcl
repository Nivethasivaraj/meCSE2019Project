# ======================================================================
# 			Cluster Formation
# ======================================================================
set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         50                         ;# max packet in ifq
set val(nn)             25                          ;# number of mobilenodes
set val(rp)             AODV                       ;# routing protocol
set val(energymodel)    EnergyModel		   ;# Energy Model
set val(initialenergy)  100			   ;# value
set val(stop) 		10

# ======================================================================
# Main Program
# ======================================================================

# Initialize Global Variables
#
set ns		[new Simulator]
set tracefile   [open cf.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open cf.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile 1000 500

# set up topography object
set topo       [new Topography]

$topo load_flatgrid 1000 500

# Create God
create-god $val(nn)

set chan [new $val(chan)];

# configure node
$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \
                -antType $val(ant) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -channel $chan \
                -topoInstance $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      OFF \
                -movementTrace OFF \
		-energyModel $val(energymodel) \
		-initialEnergy $val(initialenergy) \
		-rxPower 35.28e-3 \
		-txPower 31.32e-3 \
		-idlePower 712e-6 \
		-sleepPower 144e-9	

#Create 20 nodes
set no_clusters 8

for {set i 0} {$i < $val(nn) } { incr i } {
	set node_($i) [$ns node]
}

## Provide initial location of mobilenodes..
set mylistx {510 353 350 510 680 550 900 730 850 900 980 700 400 320 210 80 100 183 279 100 969 4 838 508 1  }
set mylisty {233 471 350 460 410 330 380 400 300 120 110 100 200 40 160 200 100 405 240 490  252 159 449 2 312 }
set mylistz {0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0  0.0 0.0 0.0 0.0 0.0 }

for { set j 0 } { $j < $val(nn) } { incr j } {
	$node_($j) set X_ [lindex $mylistx $j]
	$node_($j) set Y_ [lindex $mylisty $j]
	$node_($j) set Z_ [lindex $mylistz $j]
}

#c1
set udp2 [new Agent/UDP]
$ns attach-agent $node_(21) $udp2
set null2 [new Agent/Null]
$ns attach-agent $node_(19) $null2
set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 512
$cbr2 set interval_ 0.05
$cbr2 set random_ 1
$cbr2 set maxpkts_ 10000
$cbr2 attach-agent $udp2
$ns connect $udp2 $null2
$ns at 2.0 "$cbr2 start"
$ns at 5.0 "$cbr2 stop"





 $ns at 5.0 "$node_(14) add-mark m1 red "	
 $ns at 5.0 "$node_(15) add-mark m1 red "
 $ns at 5.0 "$node_(16) add-mark m1 red "
 $ns at 5.0 "$node_(21) add-mark m1 red "
 $ns at 5.0 "$node_(16) label CH"

 $ns at 5.0 "$node_(12) add-mark m1 purple "	
 $ns at 5.0 "$node_(13) add-mark m1 purple "
  $ns at 5.0 "$node_(12) label CH"

$ns at 0.1 "$node_(0) add-mark m1 pink "
  $ns at 0.1 "$node_(0) label SINK"

 $ns at 5.0 "$node_(9) add-mark m1 cyan "	
 $ns at 5.0 "$node_(10) add-mark m1 cyan "
 $ns at 5.0 "$node_(23) add-mark m1 cyan "
$ns at 7.0 "$node_(23) delete-mark m1 "
 $ns at 7.0 "$node_(23) add-mark m1 red square "
$ns at 5.0 "$node_(11) add-mark m1 cyan "
$ns at 7.0 "$node_(11) delete-mark m1 "
 $ns at 7.0 "$node_(11) add-mark m1 red square "
  $ns at 5.0 "$node_(10) label CH"

 $ns at 5.0 "$node_(17) add-mark m1 brown "
 $ns at 5.0 "$node_(18) add-mark m1 brown "
 $ns at 5.0 "$node_(19) add-mark m1 brown "
 $ns at 5.0 "$node_(24) add-mark m1 brown "
$ns at 7.0 "$node_(24) delete-mark m1 "
 $ns at 7.0 "$node_(24) add-mark m1 red square "
  $ns at 5.0 "$node_(17) label CH"

 $ns at 5.0 "$node_(1) add-mark m1 green "	
 $ns at 5.0 "$node_(2) add-mark m1 green "
 $ns at 6.0 "$node_(2) delete-mark m1 "
 $ns at 6.0 "$node_(2) add-mark m1 red square "
  $ns at 5.0 "$node_(1) label CH"
 
$ns at 5.0 "$node_(3) add-mark m1 blue "
 $ns at 5.0 "$node_(4) add-mark m1 blue "
 $ns at 5.0 "$node_(5) add-mark m1 blue "
 $ns at 5.0 "$node_(7) add-mark m1 blue "	
  $ns at 5.0 "$node_(4) label CH"

 $ns at 5.0 "$node_(6) add-mark m1 black "
 $ns at 5.0 "$node_(8) add-mark m1 black "
 $ns at 5.0 "$node_(20) add-mark m1 black "
 $ns at 5.0 "$node_(22) add-mark m1 black "
  $ns at 5.0 "$node_(6) label CH"

$ns at 0.01 "$node_(0) label SINK"



#$ns at 7.0 "$node_(2) label BLACKHOLE"
#$ns at 7.0 "$node_(11) label BLACKHOLE"
$ns at 3.0 "$node_(24) label BLACKHOLE"
#$ns at 7.0 "$node_(23) label BLACKHOLE"
$ns at 6.0 "$node_(16) label SENDER-1"
$ns at 6.0 "$node_(7) label RECEIVER-1"
$ns at 6.0 "$node_(10) label SENDER-2"
$ns at 6.0 "$node_(19) label RECEIVER-2"

#Define a 'finish' procedure
proc finish {} {
	global tracefile namfile
	#Close the output files
	close $tracefile
	close $namfile
	#Execute nam on the trace file
        exec nam cf.nam &
        exit 0
}

#set nodes initial size
for { set i 0 } { $i < $val(nn) } { incr i } {
$ns initial_node_pos $node_($i) 30
}


#$ns at 6.0 "[$node_(2) set ragent_] hacker"
#$ns at 7.0 "[$node_(11) set ragent_] hacker"


# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
$ns at $val(stop) "$node_($i) reset";
}

#Call the finish procedure after 20 seconds simulation time
$ns at 10.1 "finish"

#Run the simulation
$ns run 
