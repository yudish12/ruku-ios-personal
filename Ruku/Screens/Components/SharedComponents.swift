//
//  SharedComponents.swift
//  Ruku
//
//  Created on 12/18/25.
//

import SwiftUI
import FamilyControls

// MARK: - Free Plan Limit Card Component
struct FreePlanLimitCard: View {
    let blockedAppsCount: Int
    let maxAppsCount: Int
    var onRemoveLimit: () -> Void
    
    private var progress: Double {
        guard maxAppsCount > 0 else { return 0 }
        return Double(blockedAppsCount) / Double(maxAppsCount)
    }
    
    private var slotsRemaining: Int {
        max(0, maxAppsCount - blockedAppsCount)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 0) {
                HStack(spacing: 6) {
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.0, green: 0.5, blue: 0.5))
                    
                    Text("FREE PLAN LIMIT")
                        .font(.inter(weight: .bold, size: 13))
                        .foregroundColor(Color(red: 0.0, green: 0.5, blue: 0.5))
                }
                
                Spacer()
                
                Text("\(blockedAppsCount)/\(maxAppsCount) apps")
                    .font(.inter(weight: .semibold, size: 16))
                    .foregroundColor(.primary)
            }
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 10)
                    
                    // Progress
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.0, green: 0.7, blue: 0.5))
                        .frame(width: geometry.size.width * progress, height: 10)
                        .animation(.easeInOut, value: progress)
                }
            }
            .frame(height: 10)
            
            // Footer
            HStack(spacing: 0) {
                Text("\(slotsRemaining) slot\(slotsRemaining == 1 ? "" : "s") remaining")
                    .font(.inter(weight: .regular, size: 14))
                    .foregroundColor(.primary.opacity(0.8))
                
                Spacer()
                
                Button(action: onRemoveLimit) {
                    Text("Remove limit")
                        .font(.inter(weight: .semibold, size: 14))
                        .foregroundColor(Color(red: 0.0, green: 0.6, blue: 0.5))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 2)
    }
}

// MARK: - Custom Diamond Shape
struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.30273*width, y: 0.25446*height))
        path.addCurve(to: CGPoint(x: 0.69727*width, y: 0.25446*height), control1: CGPoint(x: 0.43293*width, y: 0.25446*height), control2: CGPoint(x: 0.56312*width, y: 0.25446*height))
        path.addCurve(to: CGPoint(x: 0.68959*width, y: 0.29119*height), control1: CGPoint(x: 0.69287*width, y: 0.27957*height), control2: CGPoint(x: 0.69287*width, y: 0.27957*height))
        path.addCurve(to: CGPoint(x: 0.68736*width, y: 0.29915*height), control1: CGPoint(x: 0.68886*width, y: 0.29382*height), control2: CGPoint(x: 0.68812*width, y: 0.29644*height))
        path.addCurve(to: CGPoint(x: 0.68495*width, y: 0.30763*height), control1: CGPoint(x: 0.68657*width, y: 0.30195*height), control2: CGPoint(x: 0.68577*width, y: 0.30475*height))
        path.addCurve(to: CGPoint(x: 0.6824*width, y: 0.31671*height), control1: CGPoint(x: 0.6841*width, y: 0.31066*height), control2: CGPoint(x: 0.68325*width, y: 0.31369*height))
        path.addCurve(to: CGPoint(x: 0.67694*width, y: 0.33611*height), control1: CGPoint(x: 0.68059*width, y: 0.32318*height), control2: CGPoint(x: 0.67877*width, y: 0.32965*height))
        path.addCurve(to: CGPoint(x: 0.66375*width, y: 0.38305*height), control1: CGPoint(x: 0.67252*width, y: 0.35175*height), control2: CGPoint(x: 0.66813*width, y: 0.3674*height))
        path.addCurve(to: CGPoint(x: 0.66073*width, y: 0.39381*height), control1: CGPoint(x: 0.66274*width, y: 0.38664*height), control2: CGPoint(x: 0.66174*width, y: 0.39022*height))
        path.addCurve(to: CGPoint(x: 0.63204*width, y: 0.49788*height), control1: CGPoint(x: 0.65102*width, y: 0.42845*height), control2: CGPoint(x: 0.6415*width, y: 0.46315*height))
        path.addCurve(to: CGPoint(x: 0.58984*width, y: 0.65067*height), control1: CGPoint(x: 0.61816*width, y: 0.54888*height), control2: CGPoint(x: 0.60408*width, y: 0.5998*height))
        path.addCurve(to: CGPoint(x: 0.54421*width, y: 0.81596*height), control1: CGPoint(x: 0.57444*width, y: 0.7057*height), control2: CGPoint(x: 0.55925*width, y: 0.7608*height))
        path.addCurve(to: CGPoint(x: 0.50195*width, y: 0.96875*height), control1: CGPoint(x: 0.5303*width, y: 0.86696*height), control2: CGPoint(x: 0.5162*width, y: 0.91788*height))
        path.addCurve(to: CGPoint(x: 0.49805*width, y: 0.96875*height), control1: CGPoint(x: 0.50066*width, y: 0.96875*height), control2: CGPoint(x: 0.49938*width, y: 0.96875*height))
        path.addCurve(to: CGPoint(x: 0.47998*width, y: 0.90402*height), control1: CGPoint(x: 0.49202*width, y: 0.94717*height), control2: CGPoint(x: 0.486*width, y: 0.9256*height))
        path.addCurve(to: CGPoint(x: 0.47859*width, y: 0.89902*height), control1: CGPoint(x: 0.47952*width, y: 0.90237*height), control2: CGPoint(x: 0.47906*width, y: 0.90072*height))
        path.addCurve(to: CGPoint(x: 0.43762*width, y: 0.75042*height), control1: CGPoint(x: 0.46479*width, y: 0.84953*height), control2: CGPoint(x: 0.45113*width, y: 0.8*height))
        path.addCurve(to: CGPoint(x: 0.39648*width, y: 0.60156*height), control1: CGPoint(x: 0.42408*width, y: 0.70074*height), control2: CGPoint(x: 0.41035*width, y: 0.65113*height))
        path.addCurve(to: CGPoint(x: 0.35006*width, y: 0.43343*height), control1: CGPoint(x: 0.38082*width, y: 0.54559*height), control2: CGPoint(x: 0.36535*width, y: 0.48954*height))
        path.addCurve(to: CGPoint(x: 0.34533*width, y: 0.41607*height), control1: CGPoint(x: 0.34848*width, y: 0.42764*height), control2: CGPoint(x: 0.34691*width, y: 0.42186*height))
        path.addCurve(to: CGPoint(x: 0.34416*width, y: 0.41177*height), control1: CGPoint(x: 0.34494*width, y: 0.41465*height), control2: CGPoint(x: 0.34456*width, y: 0.41323*height))
        path.addCurve(to: CGPoint(x: 0.32733*width, y: 0.35058*height), control1: CGPoint(x: 0.33859*width, y: 0.39136*height), control2: CGPoint(x: 0.33298*width, y: 0.37096*height))
        path.addCurve(to: CGPoint(x: 0.32374*width, y: 0.33762*height), control1: CGPoint(x: 0.32613*width, y: 0.34626*height), control2: CGPoint(x: 0.32494*width, y: 0.34194*height))
        path.addCurve(to: CGPoint(x: 0.31255*width, y: 0.29733*height), control1: CGPoint(x: 0.32002*width, y: 0.32419*height), control2: CGPoint(x: 0.31629*width, y: 0.31076*height))
        path.addCurve(to: CGPoint(x: 0.30862*width, y: 0.28316*height), control1: CGPoint(x: 0.31124*width, y: 0.29261*height), control2: CGPoint(x: 0.30993*width, y: 0.28788*height))
        path.addCurve(to: CGPoint(x: 0.3068*width, y: 0.27665*height), control1: CGPoint(x: 0.30802*width, y: 0.28101*height), control2: CGPoint(x: 0.30742*width, y: 0.27886*height))
        path.addCurve(to: CGPoint(x: 0.30516*width, y: 0.27072*height), control1: CGPoint(x: 0.30626*width, y: 0.27469*height), control2: CGPoint(x: 0.30572*width, y: 0.27274*height))
        path.addCurve(to: CGPoint(x: 0.30373*width, y: 0.26558*height), control1: CGPoint(x: 0.30469*width, y: 0.26902*height), control2: CGPoint(x: 0.30422*width, y: 0.26733*height))
        path.addCurve(to: CGPoint(x: 0.30273*width, y: 0.25446*height), control1: CGPoint(x: 0.30273*width, y: 0.26116*height), control2: CGPoint(x: 0.30273*width, y: 0.26116*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.73437*width, y: 0.25446*height))
        path.addCurve(to: CGPoint(x: width, y: 0.25446*height), control1: CGPoint(x: 0.82203*width, y: 0.25446*height), control2: CGPoint(x: 0.90968*width, y: 0.25446*height))
        path.addCurve(to: CGPoint(x: 0.98852*width, y: 0.27637*height), control1: CGPoint(x: 0.99658*width, y: 0.26422*height), control2: CGPoint(x: 0.99428*width, y: 0.26871*height))
        path.addCurve(to: CGPoint(x: 0.96692*width, y: 0.30776*height), control1: CGPoint(x: 0.98102*width, y: 0.2866*height), control2: CGPoint(x: 0.97389*width, y: 0.29705*height))
        path.addCurve(to: CGPoint(x: 0.93815*width, y: 0.35105*height), control1: CGPoint(x: 0.95744*width, y: 0.32229*height), control2: CGPoint(x: 0.94784*width, y: 0.3367*height))
        path.addCurve(to: CGPoint(x: 0.92358*width, y: 0.37277*height), control1: CGPoint(x: 0.93327*width, y: 0.35828*height), control2: CGPoint(x: 0.92843*width, y: 0.36552*height))
        path.addCurve(to: CGPoint(x: 0.92038*width, y: 0.37755*height), control1: CGPoint(x: 0.92253*width, y: 0.37434*height), control2: CGPoint(x: 0.92147*width, y: 0.37592*height))
        path.addCurve(to: CGPoint(x: 0.89051*width, y: 0.42233*height), control1: CGPoint(x: 0.91041*width, y: 0.39246*height), control2: CGPoint(x: 0.90046*width, y: 0.40739*height))
        path.addCurve(to: CGPoint(x: 0.86315*width, y: 0.46327*height), control1: CGPoint(x: 0.8814*width, y: 0.43599*height), control2: CGPoint(x: 0.87228*width, y: 0.44964*height))
        path.addCurve(to: CGPoint(x: 0.83789*width, y: 0.50111*height), control1: CGPoint(x: 0.85471*width, y: 0.47587*height), control2: CGPoint(x: 0.8463*width, y: 0.48849*height))
        path.addCurve(to: CGPoint(x: 0.80651*width, y: 0.5481*height), control1: CGPoint(x: 0.82744*width, y: 0.51679*height), control2: CGPoint(x: 0.81698*width, y: 0.53245*height))
        path.addCurve(to: CGPoint(x: 0.78125*width, y: 0.58594*height), control1: CGPoint(x: 0.79807*width, y: 0.5607*height), control2: CGPoint(x: 0.78966*width, y: 0.57331*height))
        path.addCurve(to: CGPoint(x: 0.74987*width, y: 0.63292*height), control1: CGPoint(x: 0.7708*width, y: 0.60161*height), control2: CGPoint(x: 0.76034*width, y: 0.61727*height))
        path.addCurve(to: CGPoint(x: 0.72461*width, y: 0.67076*height), control1: CGPoint(x: 0.74143*width, y: 0.64552*height), control2: CGPoint(x: 0.73302*width, y: 0.65814*height))
        path.addCurve(to: CGPoint(x: 0.69322*width, y: 0.71774*height), control1: CGPoint(x: 0.71416*width, y: 0.68643*height), control2: CGPoint(x: 0.7037*width, y: 0.70209*height))
        path.addCurve(to: CGPoint(x: 0.66797*width, y: 0.75558*height), control1: CGPoint(x: 0.68479*width, y: 0.73034*height), control2: CGPoint(x: 0.67637*width, y: 0.74296*height))
        path.addCurve(to: CGPoint(x: 0.63658*width, y: 0.80256*height), control1: CGPoint(x: 0.65752*width, y: 0.77125*height), control2: CGPoint(x: 0.64706*width, y: 0.78691*height))
        path.addCurve(to: CGPoint(x: 0.61133*width, y: 0.8404*height), control1: CGPoint(x: 0.62815*width, y: 0.81516*height), control2: CGPoint(x: 0.61973*width, y: 0.82778*height))
        path.addCurve(to: CGPoint(x: 0.55078*width, y: 0.9308*height), control1: CGPoint(x: 0.59121*width, y: 0.87059*height), control2: CGPoint(x: 0.57104*width, y: 0.90074*height))
        path.addCurve(to: CGPoint(x: 0.55175*width, y: 0.91209*height), control1: CGPoint(x: 0.54841*width, y: 0.92268*height), control2: CGPoint(x: 0.54947*width, y: 0.92013*height))
        path.addCurve(to: CGPoint(x: 0.55386*width, y: 0.90453*height), control1: CGPoint(x: 0.55244*width, y: 0.9096*height), control2: CGPoint(x: 0.55314*width, y: 0.9071*height))
        path.addCurve(to: CGPoint(x: 0.55623*width, y: 0.89625*height), control1: CGPoint(x: 0.55503*width, y: 0.90043*height), control2: CGPoint(x: 0.55503*width, y: 0.90043*height))
        path.addCurve(to: CGPoint(x: 0.55868*width, y: 0.88755*height), control1: CGPoint(x: 0.55705*width, y: 0.89335*height), control2: CGPoint(x: 0.55786*width, y: 0.89045*height))
        path.addCurve(to: CGPoint(x: 0.56397*width, y: 0.86882*height), control1: CGPoint(x: 0.56043*width, y: 0.88131*height), control2: CGPoint(x: 0.5622*width, y: 0.87506*height))
        path.addCurve(to: CGPoint(x: 0.57242*width, y: 0.83886*height), control1: CGPoint(x: 0.5668*width, y: 0.85884*height), control2: CGPoint(x: 0.56962*width, y: 0.84885*height))
        path.addCurve(to: CGPoint(x: 0.57386*width, y: 0.83375*height), control1: CGPoint(x: 0.5729*width, y: 0.83717*height), control2: CGPoint(x: 0.57337*width, y: 0.83548*height))
        path.addCurve(to: CGPoint(x: 0.57675*width, y: 0.82344*height), control1: CGPoint(x: 0.57482*width, y: 0.83031*height), control2: CGPoint(x: 0.57579*width, y: 0.82688*height))
        path.addCurve(to: CGPoint(x: 0.58117*width, y: 0.80772*height), control1: CGPoint(x: 0.57822*width, y: 0.8182*height), control2: CGPoint(x: 0.5797*width, y: 0.81296*height))
        path.addCurve(to: CGPoint(x: 0.60688*width, y: 0.71449*height), control1: CGPoint(x: 0.5899*width, y: 0.7767*height), control2: CGPoint(x: 0.59842*width, y: 0.7456*height))
        path.addCurve(to: CGPoint(x: 0.65039*width, y: 0.55692*height), control1: CGPoint(x: 0.62119*width, y: 0.66189*height), control2: CGPoint(x: 0.63571*width, y: 0.60938*height))
        path.addCurve(to: CGPoint(x: 0.69275*width, y: 0.40374*height), control1: CGPoint(x: 0.66466*width, y: 0.50591*height), control2: CGPoint(x: 0.67879*width, y: 0.45486*height))
        path.addCurve(to: CGPoint(x: 0.69398*width, y: 0.3992*height), control1: CGPoint(x: 0.69336*width, y: 0.40149*height), control2: CGPoint(x: 0.69336*width, y: 0.40149*height))
        path.addCurve(to: CGPoint(x: 0.70678*width, y: 0.35227*height), control1: CGPoint(x: 0.69825*width, y: 0.38356*height), control2: CGPoint(x: 0.70252*width, y: 0.36791*height))
        path.addCurve(to: CGPoint(x: 0.72262*width, y: 0.29437*height), control1: CGPoint(x: 0.71205*width, y: 0.33297*height), control2: CGPoint(x: 0.71732*width, y: 0.31367*height))
        path.addCurve(to: CGPoint(x: 0.7266*width, y: 0.27982*height), control1: CGPoint(x: 0.72395*width, y: 0.28952*height), control2: CGPoint(x: 0.72527*width, y: 0.28467*height))
        path.addCurve(to: CGPoint(x: 0.7289*width, y: 0.27143*height), control1: CGPoint(x: 0.72774*width, y: 0.27567*height), control2: CGPoint(x: 0.72774*width, y: 0.27567*height))
        path.addCurve(to: CGPoint(x: 0.73084*width, y: 0.26434*height), control1: CGPoint(x: 0.72954*width, y: 0.26909*height), control2: CGPoint(x: 0.73018*width, y: 0.26675*height))
        path.addCurve(to: CGPoint(x: 0.73437*width, y: 0.25446*height), control1: CGPoint(x: 0.73242*width, y: 0.25893*height), control2: CGPoint(x: 0.73242*width, y: 0.25893*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.25446*height))
        path.addCurve(to: CGPoint(x: 0.26563*width, y: 0.25446*height), control1: CGPoint(x: 0.08766*width, y: 0.25446*height), control2: CGPoint(x: 0.17531*width, y: 0.25446*height))
        path.addCurve(to: CGPoint(x: 0.30317*width, y: 0.38815*height), control1: CGPoint(x: 0.2782*width, y: 0.299*height), control2: CGPoint(x: 0.29075*width, y: 0.34355*height))
        path.addCurve(to: CGPoint(x: 0.30709*width, y: 0.40222*height), control1: CGPoint(x: 0.30448*width, y: 0.39284*height), control2: CGPoint(x: 0.30578*width, y: 0.39753*height))
        path.addCurve(to: CGPoint(x: 0.34678*width, y: 0.5464*height), control1: CGPoint(x: 0.32046*width, y: 0.45023*height), control2: CGPoint(x: 0.33367*width, y: 0.4983*height))
        path.addCurve(to: CGPoint(x: 0.38537*width, y: 0.68601*height), control1: CGPoint(x: 0.35948*width, y: 0.593*height), control2: CGPoint(x: 0.37236*width, y: 0.63952*height))
        path.addCurve(to: CGPoint(x: 0.42888*width, y: 0.84294*height), control1: CGPoint(x: 0.39999*width, y: 0.73828*height), control2: CGPoint(x: 0.41452*width, y: 0.79057*height))
        path.addCurve(to: CGPoint(x: 0.43274*width, y: 0.85696*height), control1: CGPoint(x: 0.43016*width, y: 0.84761*height), control2: CGPoint(x: 0.43145*width, y: 0.85229*height))
        path.addCurve(to: CGPoint(x: 0.43985*width, y: 0.88292*height), control1: CGPoint(x: 0.43512*width, y: 0.86561*height), control2: CGPoint(x: 0.43748*width, y: 0.87426*height))
        path.addCurve(to: CGPoint(x: 0.44197*width, y: 0.89059*height), control1: CGPoint(x: 0.4409*width, y: 0.88671*height), control2: CGPoint(x: 0.4409*width, y: 0.88671*height))
        path.addCurve(to: CGPoint(x: 0.45117*width, y: 0.9308*height), control1: CGPoint(x: 0.44559*width, y: 0.90391*height), control2: CGPoint(x: 0.44872*width, y: 0.91713*height))
        path.addCurve(to: CGPoint(x: 0.42822*width, y: 0.90053*height), control1: CGPoint(x: 0.44256*width, y: 0.9215*height), control2: CGPoint(x: 0.43543*width, y: 0.91126*height))
        path.addCurve(to: CGPoint(x: 0.42455*width, y: 0.89509*height), control1: CGPoint(x: 0.42701*width, y: 0.89874*height), control2: CGPoint(x: 0.4258*width, y: 0.89694*height))
        path.addCurve(to: CGPoint(x: 0.401*width, y: 0.85957*height), control1: CGPoint(x: 0.41661*width, y: 0.88332*height), control2: CGPoint(x: 0.40877*width, y: 0.87148*height))
        path.addCurve(to: CGPoint(x: 0.38464*width, y: 0.83496*height), control1: CGPoint(x: 0.3956*width, y: 0.85132*height), control2: CGPoint(x: 0.39012*width, y: 0.84314*height))
        path.addCurve(to: CGPoint(x: 0.35547*width, y: 0.79129*height), control1: CGPoint(x: 0.3749*width, y: 0.82042*height), control2: CGPoint(x: 0.36518*width, y: 0.80586*height))
        path.addCurve(to: CGPoint(x: 0.32715*width, y: 0.74889*height), control1: CGPoint(x: 0.34604*width, y: 0.77715*height), control2: CGPoint(x: 0.33661*width, y: 0.76301*height))
        path.addCurve(to: CGPoint(x: 0.29481*width, y: 0.70044*height), control1: CGPoint(x: 0.31635*width, y: 0.73275*height), control2: CGPoint(x: 0.30558*width, y: 0.7166*height))
        path.addCurve(to: CGPoint(x: 0.27051*width, y: 0.66406*height), control1: CGPoint(x: 0.28672*width, y: 0.6883*height), control2: CGPoint(x: 0.27862*width, y: 0.67618*height))
        path.addCurve(to: CGPoint(x: 0.23817*width, y: 0.61562*height), control1: CGPoint(x: 0.25971*width, y: 0.64793*height), control2: CGPoint(x: 0.24893*width, y: 0.63178*height))
        path.addCurve(to: CGPoint(x: 0.21387*width, y: 0.57924*height), control1: CGPoint(x: 0.23008*width, y: 0.60348*height), control2: CGPoint(x: 0.22198*width, y: 0.59136*height))
        path.addCurve(to: CGPoint(x: 0.18153*width, y: 0.5308*height), control1: CGPoint(x: 0.20307*width, y: 0.56311*height), control2: CGPoint(x: 0.19229*width, y: 0.54696*height))
        path.addCurve(to: CGPoint(x: 0.15723*width, y: 0.49442*height), control1: CGPoint(x: 0.17344*width, y: 0.51866*height), control2: CGPoint(x: 0.16534*width, y: 0.50654*height))
        path.addCurve(to: CGPoint(x: 0.12489*width, y: 0.44597*height), control1: CGPoint(x: 0.14643*width, y: 0.47829*height), control2: CGPoint(x: 0.13565*width, y: 0.46214*height))
        path.addCurve(to: CGPoint(x: 0.10059*width, y: 0.4096*height), control1: CGPoint(x: 0.1168*width, y: 0.43384*height), control2: CGPoint(x: 0.1087*width, y: 0.42171*height))
        path.addCurve(to: CGPoint(x: 0.06825*width, y: 0.36115*height), control1: CGPoint(x: 0.08979*width, y: 0.39347*height), control2: CGPoint(x: 0.07901*width, y: 0.37731*height))
        path.addCurve(to: CGPoint(x: 0.047*width, y: 0.32934*height), control1: CGPoint(x: 0.06117*width, y: 0.35054*height), control2: CGPoint(x: 0.05409*width, y: 0.33993*height))
        path.addCurve(to: CGPoint(x: 0.04094*width, y: 0.32028*height), control1: CGPoint(x: 0.04498*width, y: 0.32632*height), control2: CGPoint(x: 0.04296*width, y: 0.3233*height))
        path.addCurve(to: CGPoint(x: 0.02273*width, y: 0.29319*height), control1: CGPoint(x: 0.03489*width, y: 0.31123*height), control2: CGPoint(x: 0.02882*width, y: 0.3022*height))
        path.addCurve(to: CGPoint(x: 0.01404*width, y: 0.28027*height), control1: CGPoint(x: 0.01983*width, y: 0.28888*height), control2: CGPoint(x: 0.01693*width, y: 0.28458*height))
        path.addCurve(to: CGPoint(x: 0.00982*width, y: 0.27406*height), control1: CGPoint(x: 0.01265*width, y: 0.27822*height), control2: CGPoint(x: 0.01125*width, y: 0.27617*height))
        path.addCurve(to: CGPoint(x: 0.00594*width, y: 0.26828*height), control1: CGPoint(x: 0.00854*width, y: 0.27215*height), control2: CGPoint(x: 0.00726*width, y: 0.27025*height))
        path.addCurve(to: CGPoint(x: 0.00247*width, y: 0.26314*height), control1: CGPoint(x: 0.0048*width, y: 0.26659*height), control2: CGPoint(x: 0.00365*width, y: 0.26489*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.25446*height), control1: CGPoint(x: 0, y: 0.25893*height), control2: CGPoint(x: 0, y: 0.25893*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.49805*width, y: 0.00893*height))
        path.addCurve(to: CGPoint(x: 0.51333*width, y: 0.02136*height), control1: CGPoint(x: 0.5043*width, y: 0.01208*height), control2: CGPoint(x: 0.5085*width, y: 0.01585*height))
        path.addCurve(to: CGPoint(x: 0.51774*width, y: 0.02636*height), control1: CGPoint(x: 0.51478*width, y: 0.02301*height), control2: CGPoint(x: 0.51624*width, y: 0.02466*height))
        path.addCurve(to: CGPoint(x: 0.52253*width, y: 0.03186*height), control1: CGPoint(x: 0.52011*width, y: 0.02908*height), control2: CGPoint(x: 0.52011*width, y: 0.02908*height))
        path.addCurve(to: CGPoint(x: 0.52761*width, y: 0.03765*height), control1: CGPoint(x: 0.52504*width, y: 0.03472*height), control2: CGPoint(x: 0.52504*width, y: 0.03472*height))
        path.addCurve(to: CGPoint(x: 0.54136*width, y: 0.05336*height), control1: CGPoint(x: 0.5322*width, y: 0.04288*height), control2: CGPoint(x: 0.53678*width, y: 0.04812*height))
        path.addCurve(to: CGPoint(x: 0.55575*width, y: 0.0698*height), control1: CGPoint(x: 0.54615*width, y: 0.05885*height), control2: CGPoint(x: 0.55095*width, y: 0.06432*height))
        path.addCurve(to: CGPoint(x: 0.57988*width, y: 0.09741*height), control1: CGPoint(x: 0.5638*width, y: 0.079*height), control2: CGPoint(x: 0.57184*width, y: 0.0882*height))
        path.addCurve(to: CGPoint(x: 0.60783*width, y: 0.12934*height), control1: CGPoint(x: 0.58918*width, y: 0.10806*height), control2: CGPoint(x: 0.5985*width, y: 0.1187*height))
        path.addCurve(to: CGPoint(x: 0.63181*width, y: 0.15674*height), control1: CGPoint(x: 0.61583*width, y: 0.13846*height), control2: CGPoint(x: 0.62382*width, y: 0.1476*height))
        path.addCurve(to: CGPoint(x: 0.64614*width, y: 0.17311*height), control1: CGPoint(x: 0.63658*width, y: 0.1622*height), control2: CGPoint(x: 0.64136*width, y: 0.16766*height))
        path.addCurve(to: CGPoint(x: 0.66208*width, y: 0.19135*height), control1: CGPoint(x: 0.65147*width, y: 0.17918*height), control2: CGPoint(x: 0.65677*width, y: 0.18526*height))
        path.addCurve(to: CGPoint(x: 0.66691*width, y: 0.19685*height), control1: CGPoint(x: 0.66368*width, y: 0.19317*height), control2: CGPoint(x: 0.66527*width, y: 0.19498*height))
        path.addCurve(to: CGPoint(x: 0.67126*width, y: 0.20186*height), control1: CGPoint(x: 0.66835*width, y: 0.1985*height), control2: CGPoint(x: 0.66978*width, y: 0.20015*height))
        path.addCurve(to: CGPoint(x: 0.67507*width, y: 0.20622*height), control1: CGPoint(x: 0.67252*width, y: 0.2033*height), control2: CGPoint(x: 0.67378*width, y: 0.20473*height))
        path.addCurve(to: CGPoint(x: 0.67773*width, y: 0.21429*height), control1: CGPoint(x: 0.67773*width, y: 0.20982*height), control2: CGPoint(x: 0.67773*width, y: 0.20982*height))
        path.addCurve(to: CGPoint(x: 0.32227*width, y: 0.21429*height), control1: CGPoint(x: 0.56043*width, y: 0.21429*height), control2: CGPoint(x: 0.44312*width, y: 0.21429*height))
        path.addCurve(to: CGPoint(x: 0.33317*width, y: 0.19683*height), control1: CGPoint(x: 0.32568*width, y: 0.20649*height), control2: CGPoint(x: 0.32796*width, y: 0.20277*height))
        path.addCurve(to: CGPoint(x: 0.33757*width, y: 0.19178*height), control1: CGPoint(x: 0.33462*width, y: 0.19516*height), control2: CGPoint(x: 0.33607*width, y: 0.1935*height))
        path.addCurve(to: CGPoint(x: 0.34239*width, y: 0.18631*height), control1: CGPoint(x: 0.33916*width, y: 0.18998*height), control2: CGPoint(x: 0.34075*width, y: 0.18817*height))
        path.addCurve(to: CGPoint(x: 0.34747*width, y: 0.1805*height), control1: CGPoint(x: 0.34491*width, y: 0.18344*height), control2: CGPoint(x: 0.34491*width, y: 0.18344*height))
        path.addCurve(to: CGPoint(x: 0.36128*width, y: 0.16479*height), control1: CGPoint(x: 0.35207*width, y: 0.17526*height), control2: CGPoint(x: 0.35667*width, y: 0.17002*height))
        path.addCurve(to: CGPoint(x: 0.37569*width, y: 0.14834*height), control1: CGPoint(x: 0.36609*width, y: 0.15931*height), control2: CGPoint(x: 0.37089*width, y: 0.15383*height))
        path.addCurve(to: CGPoint(x: 0.403*width, y: 0.11723*height), control1: CGPoint(x: 0.38479*width, y: 0.13796*height), control2: CGPoint(x: 0.39389*width, y: 0.12759*height))
        path.addCurve(to: CGPoint(x: 0.43409*width, y: 0.08179*height), control1: CGPoint(x: 0.41337*width, y: 0.10543*height), control2: CGPoint(x: 0.42373*width, y: 0.09361*height))
        path.addCurve(to: CGPoint(x: 0.49805*width, y: 0.00893*height), control1: CGPoint(x: 0.4554*width, y: 0.05749*height), control2: CGPoint(x: 0.47672*width, y: 0.0332*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.54297*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.82031*width, y: 0), control1: CGPoint(x: 0.63449*width, y: 0), control2: CGPoint(x: 0.72602*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.81157*width, y: 0.02136*height), control1: CGPoint(x: 0.81762*width, y: 0.00771*height), control2: CGPoint(x: 0.81509*width, y: 0.01424*height))
        path.addCurve(to: CGPoint(x: 0.80863*width, y: 0.02733*height), control1: CGPoint(x: 0.8106*width, y: 0.02333*height), control2: CGPoint(x: 0.80963*width, y: 0.0253*height))
        path.addCurve(to: CGPoint(x: 0.80542*width, y: 0.03376*height), control1: CGPoint(x: 0.80757*width, y: 0.02945*height), control2: CGPoint(x: 0.80651*width, y: 0.03157*height))
        path.addCurve(to: CGPoint(x: 0.80204*width, y: 0.04057*height), control1: CGPoint(x: 0.8043*width, y: 0.03601*height), control2: CGPoint(x: 0.80319*width, y: 0.03826*height))
        path.addCurve(to: CGPoint(x: 0.77169*width, y: 0.09977*height), control1: CGPoint(x: 0.79213*width, y: 0.06045*height), control2: CGPoint(x: 0.78194*width, y: 0.08012*height))
        path.addCurve(to: CGPoint(x: 0.75168*width, y: 0.13879*height), control1: CGPoint(x: 0.76494*width, y: 0.11273*height), control2: CGPoint(x: 0.75825*width, y: 0.12571*height))
        path.addCurve(to: CGPoint(x: 0.74968*width, y: 0.14275*height), control1: CGPoint(x: 0.75069*width, y: 0.14075*height), control2: CGPoint(x: 0.75069*width, y: 0.14075*height))
        path.addCurve(to: CGPoint(x: 0.74033*width, y: 0.16147*height), control1: CGPoint(x: 0.74656*width, y: 0.14898*height), control2: CGPoint(x: 0.74344*width, y: 0.15522*height))
        path.addCurve(to: CGPoint(x: 0.71875*width, y: 0.20089*height), control1: CGPoint(x: 0.73356*width, y: 0.17498*height), control2: CGPoint(x: 0.72645*width, y: 0.18805*height))
        path.addCurve(to: CGPoint(x: 0.68864*width, y: 0.16901*height), control1: CGPoint(x: 0.70818*width, y: 0.19081*height), control2: CGPoint(x: 0.69836*width, y: 0.18014*height))
        path.addCurve(to: CGPoint(x: 0.68385*width, y: 0.16354*height), control1: CGPoint(x: 0.68627*width, y: 0.1663*height), control2: CGPoint(x: 0.68627*width, y: 0.1663*height))
        path.addCurve(to: CGPoint(x: 0.66828*width, y: 0.14574*height), control1: CGPoint(x: 0.67865*width, y: 0.15761*height), control2: CGPoint(x: 0.67347*width, y: 0.15168*height))
        path.addCurve(to: CGPoint(x: 0.65744*width, y: 0.13336*height), control1: CGPoint(x: 0.66467*width, y: 0.14161*height), control2: CGPoint(x: 0.66105*width, y: 0.13748*height))
        path.addCurve(to: CGPoint(x: 0.63479*width, y: 0.10746*height), control1: CGPoint(x: 0.64988*width, y: 0.12473*height), control2: CGPoint(x: 0.64233*width, y: 0.11609*height))
        path.addCurve(to: CGPoint(x: 0.60857*width, y: 0.0775*height), control1: CGPoint(x: 0.62605*width, y: 0.09746*height), control2: CGPoint(x: 0.61731*width, y: 0.08748*height))
        path.addCurve(to: CGPoint(x: 0.58332*width, y: 0.04864*height), control1: CGPoint(x: 0.60015*width, y: 0.06788*height), control2: CGPoint(x: 0.59173*width, y: 0.05827*height))
        path.addCurve(to: CGPoint(x: 0.57257*width, y: 0.03637*height), control1: CGPoint(x: 0.57974*width, y: 0.04455*height), control2: CGPoint(x: 0.57616*width, y: 0.04046*height))
        path.addCurve(to: CGPoint(x: 0.55763*width, y: 0.01928*height), control1: CGPoint(x: 0.56759*width, y: 0.03068*height), control2: CGPoint(x: 0.56261*width, y: 0.02498*height))
        path.addCurve(to: CGPoint(x: 0.5531*width, y: 0.01412*height), control1: CGPoint(x: 0.55614*width, y: 0.01758*height), control2: CGPoint(x: 0.55464*width, y: 0.01587*height))
        path.addCurve(to: CGPoint(x: 0.54903*width, y: 0.00944*height), control1: CGPoint(x: 0.55109*width, y: 0.0118*height), control2: CGPoint(x: 0.55109*width, y: 0.0118*height))
        path.addCurve(to: CGPoint(x: 0.54546*width, y: 0.00536*height), control1: CGPoint(x: 0.54785*width, y: 0.0081*height), control2: CGPoint(x: 0.54668*width, y: 0.00675*height))
        path.addCurve(to: CGPoint(x: 0.54297*width, y: 0), control1: CGPoint(x: 0.54297*width, y: 0.00223*height), control2: CGPoint(x: 0.54297*width, y: 0.00223*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.17969*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.45703*width, y: 0), control1: CGPoint(x: 0.27121*width, y: 0), control2: CGPoint(x: 0.36273*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.43775*width, y: 0.02454*height), control1: CGPoint(x: 0.44385*width, y: 0.01758*height), control2: CGPoint(x: 0.44385*width, y: 0.01758*height))
        path.addCurve(to: CGPoint(x: 0.43357*width, y: 0.02933*height), control1: CGPoint(x: 0.43637*width, y: 0.02612*height), control2: CGPoint(x: 0.43499*width, y: 0.0277*height))
        path.addCurve(to: CGPoint(x: 0.4291*width, y: 0.03441*height), control1: CGPoint(x: 0.43209*width, y: 0.031*height), control2: CGPoint(x: 0.43062*width, y: 0.03268*height))
        path.addCurve(to: CGPoint(x: 0.4243*width, y: 0.03989*height), control1: CGPoint(x: 0.42752*width, y: 0.03621*height), control2: CGPoint(x: 0.42593*width, y: 0.03802*height))
        path.addCurve(to: CGPoint(x: 0.40871*width, y: 0.05768*height), control1: CGPoint(x: 0.41911*width, y: 0.04582*height), control2: CGPoint(x: 0.41391*width, y: 0.05175*height))
        path.addCurve(to: CGPoint(x: 0.39785*width, y: 0.07007*height), control1: CGPoint(x: 0.40509*width, y: 0.06181*height), control2: CGPoint(x: 0.40147*width, y: 0.06594*height))
        path.addCurve(to: CGPoint(x: 0.37227*width, y: 0.09927*height), control1: CGPoint(x: 0.38933*width, y: 0.07981*height), control2: CGPoint(x: 0.3808*width, y: 0.08954*height))
        path.addCurve(to: CGPoint(x: 0.34312*width, y: 0.13253*height), control1: CGPoint(x: 0.36255*width, y: 0.11035*height), control2: CGPoint(x: 0.35283*width, y: 0.12144*height))
        path.addCurve(to: CGPoint(x: 0.2832*width, y: 0.20089*height), control1: CGPoint(x: 0.32315*width, y: 0.15532*height), control2: CGPoint(x: 0.30318*width, y: 0.17811*height))
        path.addCurve(to: CGPoint(x: 0.26932*width, y: 0.18052*height), control1: CGPoint(x: 0.27742*width, y: 0.19447*height), control2: CGPoint(x: 0.27329*width, y: 0.18856*height))
        path.addCurve(to: CGPoint(x: 0.26588*width, y: 0.17361*height), control1: CGPoint(x: 0.26761*width, y: 0.1771*height), control2: CGPoint(x: 0.26761*width, y: 0.1771*height))
        path.addCurve(to: CGPoint(x: 0.26221*width, y: 0.16615*height), control1: CGPoint(x: 0.26467*width, y: 0.17115*height), control2: CGPoint(x: 0.26345*width, y: 0.16869*height))
        path.addCurve(to: CGPoint(x: 0.2543*width, y: 0.15031*height), control1: CGPoint(x: 0.25958*width, y: 0.16087*height), control2: CGPoint(x: 0.25694*width, y: 0.15559*height))
        path.addCurve(to: CGPoint(x: 0.25225*width, y: 0.1462*height), control1: CGPoint(x: 0.25363*width, y: 0.14896*height), control2: CGPoint(x: 0.25295*width, y: 0.1476*height))
        path.addCurve(to: CGPoint(x: 0.23047*width, y: 0.10379*height), control1: CGPoint(x: 0.24514*width, y: 0.13196*height), control2: CGPoint(x: 0.23781*width, y: 0.11788*height))
        path.addCurve(to: CGPoint(x: 0.18841*width, y: 0.02126*height), control1: CGPoint(x: 0.21622*width, y: 0.07643*height), control2: CGPoint(x: 0.20226*width, y: 0.04889*height))
        path.addCurve(to: CGPoint(x: 0.18225*width, y: 0.00959*height), control1: CGPoint(x: 0.18641*width, y: 0.01733*height), control2: CGPoint(x: 0.18436*width, y: 0.01345*height))
        path.addCurve(to: CGPoint(x: 0.17969*width, y: 0), control1: CGPoint(x: 0.17969*width, y: 0.00446*height), control2: CGPoint(x: 0.17969*width, y: 0.00446*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.85352*width, y: 0.01563*height))
        path.addCurve(to: CGPoint(x: 0.86719*width, y: 0.02846*height), control1: CGPoint(x: 0.86077*width, y: 0.01839*height), control2: CGPoint(x: 0.86249*width, y: 0.02163*height))
        path.addCurve(to: CGPoint(x: 0.87189*width, y: 0.03519*height), control1: CGPoint(x: 0.86874*width, y: 0.03068*height), control2: CGPoint(x: 0.87029*width, y: 0.0329*height))
        path.addCurve(to: CGPoint(x: 0.87438*width, y: 0.03877*height), control1: CGPoint(x: 0.87271*width, y: 0.03637*height), control2: CGPoint(x: 0.87353*width, y: 0.03755*height))
        path.addCurve(to: CGPoint(x: 0.88769*width, y: 0.05692*height), control1: CGPoint(x: 0.87872*width, y: 0.04491*height), control2: CGPoint(x: 0.88321*width, y: 0.05091*height))
        path.addCurve(to: CGPoint(x: 0.9115*width, y: 0.0897*height), control1: CGPoint(x: 0.89575*width, y: 0.06774*height), control2: CGPoint(x: 0.90365*width, y: 0.07869*height))
        path.addCurve(to: CGPoint(x: 0.92676*width, y: 0.11049*height), control1: CGPoint(x: 0.91653*width, y: 0.09669*height), control2: CGPoint(x: 0.92163*width, y: 0.1036*height))
        path.addCurve(to: CGPoint(x: 0.95056*width, y: 0.14328*height), control1: CGPoint(x: 0.93481*width, y: 0.12132*height), control2: CGPoint(x: 0.94272*width, y: 0.13226*height))
        path.addCurve(to: CGPoint(x: 0.96582*width, y: 0.16406*height), control1: CGPoint(x: 0.95559*width, y: 0.15026*height), control2: CGPoint(x: 0.9607*width, y: 0.15717*height))
        path.addCurve(to: CGPoint(x: 0.97392*width, y: 0.17501*height), control1: CGPoint(x: 0.96852*width, y: 0.16771*height), control2: CGPoint(x: 0.97122*width, y: 0.17136*height))
        path.addCurve(to: CGPoint(x: 0.97917*width, y: 0.18207*height), control1: CGPoint(x: 0.97567*width, y: 0.17736*height), control2: CGPoint(x: 0.97742*width, y: 0.17972*height))
        path.addCurve(to: CGPoint(x: 0.98645*width, y: 0.19196*height), control1: CGPoint(x: 0.98161*width, y: 0.18535*height), control2: CGPoint(x: 0.98403*width, y: 0.18866*height))
        path.addCurve(to: CGPoint(x: 0.99067*width, y: 0.19768*height), control1: CGPoint(x: 0.98784*width, y: 0.19385*height), control2: CGPoint(x: 0.98923*width, y: 0.19574*height))
        path.addCurve(to: CGPoint(x: 0.99805*width, y: 0.21429*height), control1: CGPoint(x: 0.99414*width, y: 0.20313*height), control2: CGPoint(x: 0.99414*width, y: 0.20313*height))
        path.addCurve(to: CGPoint(x: 0.75391*width, y: 0.21429*height), control1: CGPoint(x: 0.91748*width, y: 0.21429*height), control2: CGPoint(x: 0.83691*width, y: 0.21429*height))
        path.addCurve(to: CGPoint(x: 0.764*width, y: 0.18844*height), control1: CGPoint(x: 0.75687*width, y: 0.20414*height), control2: CGPoint(x: 0.75931*width, y: 0.19731*height))
        path.addCurve(to: CGPoint(x: 0.76778*width, y: 0.18124*height), control1: CGPoint(x: 0.76525*width, y: 0.18606*height), control2: CGPoint(x: 0.76649*width, y: 0.18369*height))
        path.addCurve(to: CGPoint(x: 0.76979*width, y: 0.17745*height), control1: CGPoint(x: 0.76844*width, y: 0.17999*height), control2: CGPoint(x: 0.7691*width, y: 0.17874*height))
        path.addCurve(to: CGPoint(x: 0.7804*width, y: 0.15722*height), control1: CGPoint(x: 0.77335*width, y: 0.17072*height), control2: CGPoint(x: 0.77687*width, y: 0.16397*height))
        path.addCurve(to: CGPoint(x: 0.7826*width, y: 0.15302*height), control1: CGPoint(x: 0.78113*width, y: 0.15583*height), control2: CGPoint(x: 0.78185*width, y: 0.15445*height))
        path.addCurve(to: CGPoint(x: 0.80396*width, y: 0.11119*height), control1: CGPoint(x: 0.78985*width, y: 0.13917*height), control2: CGPoint(x: 0.79692*width, y: 0.12519*height))
        path.addCurve(to: CGPoint(x: 0.81115*width, y: 0.0969*height), control1: CGPoint(x: 0.80635*width, y: 0.10642*height), control2: CGPoint(x: 0.80875*width, y: 0.10166*height))
        path.addCurve(to: CGPoint(x: 0.81473*width, y: 0.08979*height), control1: CGPoint(x: 0.81233*width, y: 0.09455*height), control2: CGPoint(x: 0.81351*width, y: 0.09221*height))
        path.addCurve(to: CGPoint(x: 0.83337*width, y: 0.05301*height), control1: CGPoint(x: 0.82092*width, y: 0.07752*height), control2: CGPoint(x: 0.82714*width, y: 0.06526*height))
        path.addCurve(to: CGPoint(x: 0.83678*width, y: 0.04629*height), control1: CGPoint(x: 0.83506*width, y: 0.04968*height), control2: CGPoint(x: 0.83506*width, y: 0.04968*height))
        path.addCurve(to: CGPoint(x: 0.85352*width, y: 0.01563*height), control1: CGPoint(x: 0.84211*width, y: 0.03584*height), control2: CGPoint(x: 0.84751*width, y: 0.02558*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.14258*width, y: 0.01563*height))
        path.addCurve(to: CGPoint(x: 0.15432*width, y: 0.02865*height), control1: CGPoint(x: 0.14999*width, y: 0.01845*height), control2: CGPoint(x: 0.15056*width, y: 0.02098*height))
        path.addCurve(to: CGPoint(x: 0.15778*width, y: 0.03562*height), control1: CGPoint(x: 0.15546*width, y: 0.03095*height), control2: CGPoint(x: 0.1566*width, y: 0.03325*height))
        path.addCurve(to: CGPoint(x: 0.1615*width, y: 0.04325*height), control1: CGPoint(x: 0.15901*width, y: 0.03814*height), control2: CGPoint(x: 0.16023*width, y: 0.04066*height))
        path.addCurve(to: CGPoint(x: 0.16946*width, y: 0.05927*height), control1: CGPoint(x: 0.16414*width, y: 0.04859*height), control2: CGPoint(x: 0.1668*width, y: 0.05393*height))
        path.addCurve(to: CGPoint(x: 0.17152*width, y: 0.06345*height), control1: CGPoint(x: 0.17048*width, y: 0.06134*height), control2: CGPoint(x: 0.17048*width, y: 0.06134*height))
        path.addCurve(to: CGPoint(x: 0.19336*width, y: 0.10603*height), control1: CGPoint(x: 0.17863*width, y: 0.07776*height), control2: CGPoint(x: 0.18598*width, y: 0.09189*height))
        path.addCurve(to: CGPoint(x: 0.23539*width, y: 0.18845*height), control1: CGPoint(x: 0.20759*width, y: 0.13336*height), control2: CGPoint(x: 0.22157*width, y: 0.16085*height))
        path.addCurve(to: CGPoint(x: 0.24083*width, y: 0.19914*height), control1: CGPoint(x: 0.23719*width, y: 0.19203*height), control2: CGPoint(x: 0.239*width, y: 0.19559*height))
        path.addCurve(to: CGPoint(x: 0.24609*width, y: 0.21429*height), control1: CGPoint(x: 0.24609*width, y: 0.20936*height), control2: CGPoint(x: 0.24609*width, y: 0.20936*height))
        path.addCurve(to: CGPoint(x: 0.00195*width, y: 0.21429*height), control1: CGPoint(x: 0.16553*width, y: 0.21429*height), control2: CGPoint(x: 0.08496*width, y: 0.21429*height))
        path.addCurve(to: CGPoint(x: 0.01118*width, y: 0.19557*height), control1: CGPoint(x: 0.00635*width, y: 0.20174*height), control2: CGPoint(x: 0.00635*width, y: 0.20174*height))
        path.addCurve(to: CGPoint(x: 0.01434*width, y: 0.19149*height), control1: CGPoint(x: 0.01222*width, y: 0.19423*height), control2: CGPoint(x: 0.01326*width, y: 0.19288*height))
        path.addCurve(to: CGPoint(x: 0.0177*width, y: 0.18722*height), control1: CGPoint(x: 0.01545*width, y: 0.19008*height), control2: CGPoint(x: 0.01656*width, y: 0.18867*height))
        path.addCurve(to: CGPoint(x: 0.02465*width, y: 0.17822*height), control1: CGPoint(x: 0.02002*width, y: 0.18422*height), control2: CGPoint(x: 0.02234*width, y: 0.18122*height))
        path.addCurve(to: CGPoint(x: 0.02808*width, y: 0.17378*height), control1: CGPoint(x: 0.02578*width, y: 0.17676*height), control2: CGPoint(x: 0.02692*width, y: 0.17529*height))
        path.addCurve(to: CGPoint(x: 0.04445*width, y: 0.15121*height), control1: CGPoint(x: 0.03371*width, y: 0.16642*height), control2: CGPoint(x: 0.03906*width, y: 0.15881*height))
        path.addCurve(to: CGPoint(x: 0.05957*width, y: 0.13058*height), control1: CGPoint(x: 0.04942*width, y: 0.14426*height), control2: CGPoint(x: 0.05448*width, y: 0.13742*height))
        path.addCurve(to: CGPoint(x: 0.0791*width, y: 0.10379*height), control1: CGPoint(x: 0.06616*width, y: 0.12172*height), control2: CGPoint(x: 0.07268*width, y: 0.11281*height))
        path.addCurve(to: CGPoint(x: 0.09863*width, y: 0.07701*height), control1: CGPoint(x: 0.08552*width, y: 0.09478*height), control2: CGPoint(x: 0.09205*width, y: 0.08587*height))
        path.addCurve(to: CGPoint(x: 0.14258*width, y: 0.01563*height), control1: CGPoint(x: 0.11361*width, y: 0.05685*height), control2: CGPoint(x: 0.12817*width, y: 0.03631*height))
        path.closeSubpath()
        return path
    }
}

// MARK: - Upgrade Card Component
struct UpgradeCard: View {
    var onUpgrade: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Diamond Icon
            ZStack {
                Circle()
                    .fill(Color(red: 0.0, green: 0.5, blue: 0.5).opacity(0.9))
                    .frame(width: 44, height: 44)
                
                DiamondShape()
                    .fill(.white)
                    .frame(width: 20, height: 18)
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text("Need more focus?")
                    .font(.inter(weight: .bold, size: 14))
                    .foregroundColor(.white)
                
                Text("Block unlimited apps with Premium")
                    .font(.inter(weight: .regular, size: 12))
                    .foregroundColor(.white.opacity(0.9))
            }
            
            Spacer()
            
            // Upgrade Button
            Button(action: onUpgrade) {
                Text("Upgrade")
                    .font(.inter(weight: .bold, size: 13))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(red: 0.0, green: 0.9, blue: 0.4))
                    .cornerRadius(6)
            }
        }
        .padding(16)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 2)
    }
}

struct FamilyActivityPickerSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selection: FamilyActivitySelection

    var body: some View {
        NavigationView {
            FamilyActivityPicker(selection: $selection)
                .navigationTitle("Select Apps")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

struct SelectedAppItem: View {
    let index: Int
    let onRemove: () -> Void

    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 32, height: 32)
                .overlay(
                    Image(systemName: "app.fill")
                        .foregroundColor(.gray)
                )

            Text("Blocked App \(index + 1)")
                .font(.inter(weight: .regular, size: 16))

            Spacer()

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 20))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}


struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "app.badge.plus")
                .font(.system(size: 48))
                .foregroundColor(.white.opacity(0.3))

            Text("No apps selected")
                .foregroundColor(.white.opacity(0.7))

            Text("Tap above to select apps to block")
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(.vertical, 40)
    }
}
