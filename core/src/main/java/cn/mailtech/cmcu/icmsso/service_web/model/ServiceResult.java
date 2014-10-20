package cn.mailtech.cmcu.icmsso.service_web.model;

public class ServiceResult {
    private int retCode = 0;
    private String message = "";

    public ServiceResult() {
    }

    public ServiceResult(int retCode, String message) {
        this.retCode = retCode;
        this.message = message;
    }

    public ServiceResult setCodeAndMessage(int retCode, String message) {
        setRetCode(retCode);
        setMessage(message);

        return this;
    }

    public int getRetCode() {
        return retCode;
    }

    public void setRetCode(int retCode) {
        this.retCode = retCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
