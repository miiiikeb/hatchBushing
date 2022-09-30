include<../library/mbLib-0.1b.scad>;
include<hatchBushing.cfg>;



module centerPos(outerPushFitR){

	centerRidgeH = centerH - 2 * centerConeH;

	qCyl(rad=outerPushFitR,hei=centerH,res=1,os=[0,0,0],rot=[0,0,0]);
	for (a = [0: 360/centerRidgeCount: 359]){
		rotate([0,0,a]) {
			qCyl(rad=ridgeR,hei=centerRidgeH,res=coneRes,os=[outerPushFitR,0,centerConeH],rot=[0,0,0]);
			qCone(rad1=ridgeR,rad2=0.001,hei=centerConeH,res=coneRes,os=[outerPushFitR,0,centerConeH + centerRidgeH],rot=[0,0,0]);
			qCone(rad1=0.001,rad2=ridgeR,hei=centerConeH,res=coneRes,os=[outerPushFitR,0,0],rot=[0,0,0]);
		}
	}
}

module centerNeg(){
	qCyl(rad=innerR,hei=big,res=1,os=[0,0,-big/2],rot=[0,0,0]);
	qCyl(rad=M6socketHeadR,hei=2 * M6socketHeadZ,res=1,os=[0,0,centerH - M6socketHeadZ],rot=[0,0,0]);
}

module centerMake(outerPushFitR){
	difference(){
		centerPos(outerPushFitR);
		centerNeg();
	}
}


module edgePos(outerPushFitR){

	edgeRidgeH = edgeH - 2 * edgeConeH;


	qCyl(rad=outerPushFitR,hei=edgeH,res=1,os=[0,0,0],rot=[0,0,0]);
	for (a = [0: 360/edgeRidgeCount: 359]){
		rotate([0,0,a]) {
			qCyl(rad=ridgeR,hei=edgeRidgeH,res=coneRes,os=[outerPushFitR,0,edgeConeH],rot=[0,0,0]);
			qCone(rad1=ridgeR,rad2=0.001,hei=edgeConeH,res=coneRes,os=[outerPushFitR,0,edgeConeH + edgeRidgeH],rot=[0,0,0]);
			qCone(rad1=0.001,rad2=ridgeR,hei=edgeConeH,res=coneRes,os=[outerPushFitR,0,0],rot=[0,0,0]);
		}
	}

}

module edgeNeg(){
	qCyl(rad=innerR,hei=big,res=1,os=[0,0,-big/2],rot=[0,0,0]);
}

module edgeMake(outerPushFitR){
	difference(){
		edgePos(outerPushFitR);
		edgeNeg();
	}
}

for(i = [0:0]){
	yOS = 20;
	translate([0,i * yOS,0]){
		centerMake(outerPushFitR);
		translate([20,0,0]) edgeMake(outerPushFitR);
	}
}

echo("edgeH:",edgeH);
echo("centerH:",centerH);
echo("totalH:", edgeH + centerH);