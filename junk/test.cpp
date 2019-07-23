#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <lua/lua.hpp> // lua

lua_State *L;
//////////////////////
void init_lua() {
    L = luaL_newstate();
    luaL_openlibs(L);
}
//////////////////////
bool load_script(const char *filename) 
{
    if(luaL_dofile(L,filename) != 0) 
        return false;
    return true;  // load success!
}
//////////////////////
void lua_exec(const char *lua_cmd) // executes any line or function in lua
{
	luaL_dostring(L, lua_cmd);
}
//////////////////////
// testing area
class NPC {
 public:
  void set_name(std::string name);
  std::string get_name();
 private:
  std::string name;
};
void NPC::set_name(std::string name) { this->name = name;}
std::string NPC::get_name() { return name;}
//////////////////////
int main(int argc, char *argv[]) 
{
	// start Lua
    L = luaL_newstate();
    luaL_openlibs(L); 
    // load Lua data
    if(!load_script("luac.out")) 
    {
	    printf("load failed!\n");
        lua_error(L);	 
    }
    // C++ object 
    NPC * king = new NPC();
	
    // Lua object
    lua_getglobal(L, "king");
    if(lua_istable(L, -1)) 
    {
        lua_getfield(L, -1, "get_name");
	    if(lua_isfunction(L, -1)) 
	    {
	        lua_pushvalue(L, -2); // push 'king' as first arg in 'get_name()'
	        lua_call(L, 1, 1); // one arg(king) and one return
			// store king:get_name() in king->name
		    king->set_name(lua_tostring(L, -1));
		    std::cout << king->get_name() << "\n";
	    }
	    else 
	        std::cout << "(ERROR): not a valid function\n";
    }
    else 
        std::cout << "not a valid table.\n";
  
    // close Lua
    lua_close(L);
    system("pause");
    return 0;
}