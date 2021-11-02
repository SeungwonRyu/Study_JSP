package table;

public class FeatureDTO {
    String serverName;
    String feature;
    int maxLicense;
    int updateLicense;

    public FeatureDTO(String serverName, String feature, int maxLicense, int updateLicense) {
        this.serverName = serverName;
        this.feature = feature;
        this.maxLicense = maxLicense;
        this.updateLicense = updateLicense;
    }

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    public String getFeature() {
        return feature;
    }
    public void setFeature(String feature) {
        this.feature = feature;
    }

    public int getMaxLicense() {
        return maxLicense;
    }

    public void setMaxLicense(int maxLicense) {
        this.maxLicense = maxLicense;
    }

    public int getUpdateLicense() {
        return updateLicense;
    }

    public void setUpdateLicense(int updateLicense) {
        this.updateLicense = updateLicense;
    }

}