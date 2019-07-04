struct Env {
    private static let production : Bool = {
        #if DEBUG
            return false
        #elseif RELEASE
            return true
        #else
            return false
        #endif
    }()
    
    static func isProduction () -> Bool {
        return self.production
    }
}
