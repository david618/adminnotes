import json
import random

a = json.loads('{"xmin":-313086.06786525995,"ymin":5009377.085704222,"xmax":-156543.03393729404,"ymax":5165920.119632188,"spatialReference":{"wkid":102100,"latestWkid":3857}}')

#print a



xminbase = -8766409.89997542
yminbase = 4852834.051776294
xmaxbase = -8609866.866047455
ymaxbase = 5009377.08570426




filename = r"envelopes2.txt"
fout = open(filename, "w")

num_samples = 100000
cnt = 0

while cnt < num_samples:


    shiftx = random.uniform(-100000,100000)
    shifty = random.uniform(-100000,100000)
    
    xmin = xminbase + shiftx;
    ymin = yminbase + shifty;
    xmax = xmaxbase + shiftx;
    ymax = ymaxbase + shifty;
                 
    geom = {}
    geom["xmin"] = xmin
    geom["ymin"] = ymin
    geom["xmax"] = xmax
    geom["ymax"] = ymax

    sr = {}
    sr["wkid"] = 102100
    sr["latestWkid"] = 3857

    geom["spatialReference"] = sr

    line=json.dumps(geom)
    fout.write(line + "\n")
    cnt += 1


fout.close()
        

#        lon = random.uniform(-180,179-size)
#        lat = random.uniform(-80,80-size)
#        lllon = str(lon)
#        lllat = str(lat)
#        urlon = str(lon + size)
#        urlat = str(lat + size)
#
#        bbox = lllon + "," + lllat + "," + urlon + "," + urlat + "\n"
#
#        fout.write(bbox)
#        cnt += 1

#    fout.close()
