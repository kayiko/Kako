#include<Kako.h>
class SandBox : public Kako::Application {
    public:
        SandBox() {

        }
        ~SandBox() {

        }
};
Kako::Application* Kako::CreateApplication() {
    return new SandBox();
}