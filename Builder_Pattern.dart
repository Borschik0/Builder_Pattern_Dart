enum Factory{Factory1, Factory2, Factory3}
enum Country{China, Ukraine, Germany}
enum SocketType {SocketAM4, IntegratedCPU, Socket775}
enum ChipsetType {AMDB450, SoC, IntelQ45}
enum FormfactorType {MicroATX, MiniITX}
enum RAM {DDR4DIMM, DDR3DIMM, DDR3}

class MotherboardBase{
  final Country country;
  final Factory factory;
  
  const MotherboardBase(this.country, this.factory);
  
  @override
  String toString(){
    var countryStr = country.toString().split('.')[1];
    var factoryStr = factory.toString().split('.')[1];
    return 'Country: $countryStr\nFactory: $factoryStr\n';
  } 
}

class Motherboard {
  String name;
  MotherboardBase info;
  SocketType socket;
  ChipsetType chipset;
  FormfactorType formfactor;
  RAM ram;
  
  Motherboard({this.name = 'Noname',
              this.info = const MotherboardBase(Country.China, Factory.Factory1),
              this.socket = SocketType.IntegratedCPU,
              this.chipset = ChipsetType.AMDB450,
              this.formfactor = FormfactorType.MicroATX,
              this.ram = RAM.DDR3});
  
  @override
  String toString(){
    var infoStr = 'Motherboard name: $name \n';
    infoStr+= info.toString();
    infoStr+= 'Socket type: ${socket.toString().split('.')[1]}\n';
    infoStr+= 'Chipset type: ${chipset.toString().split('.')[1]}\n';
    infoStr+= 'FormFactor type: ${formfactor.toString().split('.')[1]}\n';
    infoStr+= 'RAM: ${ram.toString().split('.')[1]}';
    return infoStr;
  }
}

abstract class Builder{
  void infoMB();
  void selectSocket();
  void selectChipset();
  void selectFormFactor();
  void selectRAM();
  
  Motherboard getMotherboard();
}

//first model of Motherboard
class GigabyteB450MGamingBuilder implements Builder {
  late Motherboard _motherboard;
  
  GigabyteB450MGamingBuilder(){
    _motherboard = Motherboard(name: 'Gigabyte B450M Gaming');
  }
  
  @override
  void infoMB(){
    _motherboard.info = MotherboardBase(Country.China, Factory.Factory2);
  }
  
  @override
  void selectSocket(){
    _motherboard.socket = SocketType.SocketAM4;
  }
  
  @override
  void selectChipset(){
    _motherboard.chipset = ChipsetType.AMDB450;
  }
  
  @override
  void selectFormFactor(){
    _motherboard.formfactor = FormfactorType.MicroATX;
  }
  
  @override
  void selectRAM(){
    _motherboard.ram = RAM.DDR4DIMM;
  }
  
  @override
  Motherboard getMotherboard(){
    return _motherboard;
  }
}

//second Model of Motherboard
class GigabyteGA_E6010NBuilder implements Builder {
  late Motherboard _motherboard;
  
  GigabyteGA_E6010NBuilder(){
    _motherboard = Motherboard(name: 'Gigabyte GA-E6010N');
  }
  
  @override
  void infoMB(){
    _motherboard.info = MotherboardBase(Country.China, Factory.Factory3);
  }
  
  @override
  void selectSocket(){
    _motherboard.socket = SocketType.IntegratedCPU;
  }
  
  @override
  void selectChipset(){
    _motherboard.chipset = ChipsetType.SoC;
  }
  
  @override
  void selectFormFactor(){
    _motherboard.formfactor = FormfactorType.MiniITX;
  }
  
  @override
  void selectRAM(){
    _motherboard.ram = RAM.DDR3DIMM;
  }
  
  @override
  Motherboard getMotherboard(){
    return _motherboard;
  }
}

//third Model of Motherboard
class DellE93839TE0423Builder implements Builder {
  late Motherboard _motherboard;
  
  DellE93839TE0423Builder(){
    _motherboard = Motherboard(name: 'Dell E93839 TE0423');
  }
  
  @override
  void infoMB(){
    _motherboard.info = MotherboardBase(Country.China, Factory.Factory1);
  }
  
  @override
  void selectSocket(){
    _motherboard.socket = SocketType.Socket775;
  }
  
  @override
  void selectChipset(){
    _motherboard.chipset = ChipsetType.IntelQ45;
  }
  
  @override
  void selectFormFactor(){
    _motherboard.formfactor = FormfactorType.MicroATX;
  }
  
  @override
  void selectRAM(){
    _motherboard.ram = RAM.DDR3;
  }
  
  @override
  Motherboard getMotherboard(){
    return _motherboard;
  }
}

class Director{
  Builder? _builder;
  
  Director([this._builder]);
  
  set builder(Builder builder) => _builder = builder;
  
  void createMotherboard(){
    assert(_builder != null, 'Oo');
    _builder?.infoMB();
    _builder?.selectChipset();
    _builder?.selectFormFactor();
    _builder?.selectRAM();
    _builder?.selectSocket();
  }
}

void main(List<String> arguments){
  var director = Director();
  for (var it in <Builder>[GigabyteB450MGamingBuilder(), GigabyteGA_E6010NBuilder(), DellE93839TE0423Builder()]){
    director.builder = it;
    director.createMotherboard();
    print(it.getMotherboard());
    print('---' * 20);
  }
}
