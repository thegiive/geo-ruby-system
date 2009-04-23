class UCoordSys
  TWD97 = { 
    :d_a    => 6378137.0 ,
    :d_f    => 1/298.257222101,
    :d_long => 121.0,
    :d_scale=> 0.9999,
    :d_fe   => 250000.0
  }    

  def self.Twd97ToWGS84 xcoor , ycoor
    e2 = 2 * TWD97[:d_f] - TWD97[:d_f] * TWD97[:d_f]
    ep2 = e2 / (1 - e2)
    m1 = ycoor / TWD97[:d_scale]
    mu1 = m1 / (TWD97[:d_a] * (1 - e2 / 4 - 3 * e2 * e2 / 64 - 5 * e2 * e2 * e2 / 256))
    e1 = (1 - Math.sqrt(1 - e2)) / (1 + Math.sqrt(1 - e2))
    phi1 = mu1 + (3 * e1 / 2 - 27 * (e1 ** 3) / 32) * Math.sin(2 * mu1) + (21 * e1 * e1 / 16 - 55 * (e1 ** 4) / 32) * Math.sin(4 * mu1) + 151 * (e1 ** 3) / 96 * Math.sin(6 * mu1) + 1097 * (e1 ** 4) / 512 * Math.sin(8 * mu1)
    v1 = TWD97[:d_a] / Math.sqrt(1 - e2 * (Math.sin(phi1) ** 2))
    ro1 = TWD97[:d_a] * (1 - e2) / (1 - e2 * (Math.sin(phi1) ** 2) ** 1.5)
    t1 = (Math.tan(phi1) ** 2)
    c1 = ep2 * (Math.cos(phi1) ** 2)
    d = (xcoor - TWD97[:d_fe]) / (v1 * TWD97[:d_scale])
    outLon = TWD97[:d_long]/180*Math::PI + (d - (1 + 2 * t1 + c1) * d * d * d / 6 + (5 - 2 * c1 + 28 * t1 - 3 * c1 * c1 + 8 * ep2 + 24 * t1 * t1) * (d ** 5) / 120) / Math.cos(phi1) 
    outLat = phi1 - (v1 * Math.tan(phi1) / ro1) * (d * d / 2 - (5 + 3 * t1 + 10 * c1 - 4 * c1 * c1 - 9 * ep2) * (d ** 4) / 24 + (61 + 90 * t1 + 298 * c1 + 45 * t1 * t1 - 252 * ep2 - 3 * c1 * c1) * (d ** 6) / 720)
    outLon = outLon/Math::PI*180
    outLat = outLat/Math::PI*180
    return outLat , outLon
  end  

  def self.Wgs84ToTWD97 (ycoor,xcoor) 
    xcoor = xcoor/180*Math::PI
    ycoor = ycoor/180*Math::PI
    e2 = 2 * TWD97[:d_f] - TWD97[:d_f] * TWD97[:d_f]
    ep2 = e2 / (1 - e2)
    t = (Math.tan(ycoor) **2)
    c = e2 * (Math.cos(ycoor) ** 2) / (1 - e2)
    a = (xcoor - TWD97[:d_long]/180*Math::PI) * Math.cos(ycoor)
    v = TWD97[:d_a] / Math.sqrt(1 - e2 * (Math.sin(ycoor) ** 2))
    m = TWD97[:d_a] * ( (1 - e2 / 4 - 3 * e2 * e2 / 64 - 5 * e2 * e2 * e2 / 256) * ycoor - (3 * e2 / 8 + 3 * e2 * e2 / 32 + 45 * e2 * e2 * e2 / 1024) * Math.sin(2 * ycoor) + (15 * e2 * e2 / 256 + 45 * e2 * e2 * e2 / 1024) * Math.sin(4 * ycoor) - (35 * e2 * e2 * e2 / 3072) * Math.sin(6 * ycoor))
    outX = TWD97[:d_fe] + TWD97[:d_scale] * v * (a + (1 - t + c) * a * a * a / 6 + (5 - 18 * t + t * t + 72 * c - 58 * ep2) * (a ** 5) / 120)
    outY = TWD97[:d_scale] * (m + v * Math.tan(ycoor) * (a * a / 2 + (5 - t + 9 * c + 4 * c * c) * (a ** 4) / 24 + (61 - 58 * t + t * t + 600 * c - 330 * ep2) * (a ** 6) / 720))
    return outX , outY
  end      
end        
